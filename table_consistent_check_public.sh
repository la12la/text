#!/bin/bash
# 增量数据所在的日期分区
do_date=$1
# 校验数据源表的表名
source_table_name=$2
# 检验数据源表的字段（与目标表顺序一致才能对比两个字段）
source_column=$3
# 检验数据目标表的表名
target_table_name=$4
# 检验数据目标表的字段（与源表顺序一致才能对比两个字段）
target_column=$5

# 初始化SQL查询语句
join_on_sql_str=''
# 将检验数据源表的字段切成列名数组
source_column_array=(${source_column//,/ })
# 将检验数据目标表的字段切成列名数组
target_column_array=(${target_column//,/ })

# 遍历数组，拼接表关联条件，输入字段全部关联
for(( i=0;i<${#source_column_array[@]};i++)) do
   if [ $i -eq 0 ];then
        join_on_sql_str=" on $source_table_name.${source_column_array[i]}=$target_table_name.${target_column_array[i]} "
   else
        join_on_sql_str="$join_on_sql_str and $source_table_name.${source_column_array[i]}=$target_table_name.${target_column_array[i]} "
   fi
done;

echo "-------------ods-dwd  一致性检查-------------"
# 执行数据源表和目标表关联查询SQL语句，查询数据一致的条数
consistent_data_query_result=`hive -e "select count(*) from gmall.$source_table_name join gmall.$target_table_name $join_on_sql_str"`
# 取出全表查询数据一致的条数
consistent_data_count=${consistent_data_query_result:3}

echo "---------------ods层记录条数-----------------"
# 执行查询数据源表的记录条数
source_table_query_result=`hive -e "select count(*) from gmall.$source_table_name"`
# 取出全表数据源表的记录条数
source_table_count=${source_table_query_result:3}

echo "---------------dwd层记录条数-----------------"
# 执行查询数据目标表的记录条数
target_table_query_result=`hive -e "select count(*) from gmall.$target_table_name"`
# 取出全表数据目标表的记录条数
target_table_count=${target_table_query_result:3}

# 执行全表重复值的记录数量SQL查询语句
table_duplicate_query_result=`hive -e "select sum(tmp.duplicate_count) as duplicate_sum from (select count(*) as duplicate_count from gmall.$target_table_name group by $target_column having count(*)>1) as tmp"`
# 取出全表重复值数据记录数量
duplicate_count=${table_duplicate_query_result:3}

# 将所有数据检验结果插入到表中
hive -e "insert into datacheck.dwd_table_data_check values('$do_date','gmall','$source_table_name','$source_column','$target_table_name','$target_column','$consistent_data_count','$source_table_count','$target_table_count','$duplicate_count')"
