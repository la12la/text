#!/bin/bash
# 增量数据所在的日期分区
do_date=$1
# 校验数据的表名
table_name=$2
# 需要校验空值的列名，以逗号’,’隔开
null_column=$3
# 将空值检验字符串切成列名数组
null_where_sql_str=''
# 遍历数组，拼接空值查询条件
array=(${null_column//,/ })
# 遍历数组，拼接空值查询条件
for(( i=0;i<${#array[@]};i++)) do
   if [ $i -eq 0 ];then
        null_where_sql_str=" where ${array[i]} is null "
   else
        null_where_sql_str="$null_where_sql_str or ${array[i]} is null "
   fi
done;
# 执行当日全表数据记录数量SQL查询语句table_count_query_result=`hive -e "select count(*) from gmall.$table_name"`
# 取出当日全量数据记录数量
table_count=${table_count_query_result:3}
# 执行全表空值数据记录数量SQL查询语句
table_null_query_result=`hive -e "select count(*) from gmall.$table_name $null_where_sql_str"`
# 取出全表空值数据记录数量
null_count=${table_null_query_result:3}

# 执行全表重复值的记录数量SQL查询语句
table_duplicate_query_result=`hive -e "select sum(tmp.duplicate_count) as duplicate_sum from (select count(*) as duplicate_count from gmall.$table_name group by $null_column having count(*)>1) as tmp"`
# 取出全表重复值数据记录数量
duplicate_count=${table_duplicate_query_result:3}

# 将所有数据检验结果插入到表中
hive -e "insert into datacheck.table_count_add_standard values('$do_date','gmall','$table_name','total_table',null,'$null_count','$duplicate_count','$table_count')"