#!/bin/bash
# 增量数据所在的日期分区
do_date=$1

hive -e "insert into datacheck.ads_table_data_check select 
    temp.data_date,
    temp.database_name,
    temp.table_name,
    temp.column_name,
    temp.healthy_value,
    temp.new_mid_count,
    temp.is_healthy
from (
    select 
        \"$do_date\" as data_date,
        \"gmall\" as database_name,
        \"ads_new_mid_count\" as table_name,
        \"new_mid_count\" as column_name,
        \"bigger than 3\" as healthy_value,
        new_mid_count,
        if(new_mid_count>3,1,0) as is_healthy
    from gmall.ads_new_mid_count
) as temp
"