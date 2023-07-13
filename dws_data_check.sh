#!/bin/bash
data_date=$1

# 每日会员行为
/opt/module/data_check/sh/total_data_check_public.sh $data_date dws_user_action_daycount user_id,login_count,cart_count,order_count

# 每日商品行为
/opt/module/data_check/sh/total_data_check_public.sh $data_date dws_sku_action_daycount sku_id,order_count,order_num,order_amount,payment_count,payment_num,payment_amount,refund_count

# 每日活动行为
/opt/module/data_check/sh/total_data_check_public.sh $data_date dws_activity_info_daycount id,activity_name,activity_type,start_time,end_time,create_time,display_count

# 每日地区统计
/opt/module/data_check/sh/total_data_check_public.sh $data_date dws_area_stats_daycount id,province_name,area_code,iso_code,region_id,region_name,login_count,order_count,order_amount,payment_count,payment_amount

