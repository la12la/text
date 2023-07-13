#!/bin/bash
# 数据所在的日期分区
do_date=$1

/opt/module/data_check/sh/table_consistent_check_public.sh $do_date ods_coupon_info id,coupon_name,coupon_type,condition_amount,condition_num,activity_id,benefit_amount,benefit_discount,create_time,range_type,spu_id,tm_id,category3_id,limit_num,operate_time,expire_time dwd_dim_coupon_info id,coupon_name,coupon_type,condition_amount,condition_num,activity_id,benefit_amount,benefit_discount,create_time,range_type,spu_id,tm_id,category3_id,limit_num,operate_time,expire_time

/opt/module/data_check/sh/table_consistent_check_public.sh $do_date ods_order_detail id,order_id,user_id,sku_id,sku_name,order_price,sku_num,create_time dwd_fact_order_detail id,order_id,user_id,sku_id,sku_name,order_price,sku_num,create_time

/opt/module/data_check/sh/table_consistent_check_public.sh $do_date ods_payment_info id,out_trade_no,order_id,user_id,alipay_trade_no,total_amount,subject,payment_type,payment_time dwd_fact_payment_info id,out_trade_no,order_id,user_id,alipay_trade_no,payment_amount,subject,payment_type,payment_time

/opt/module/data_check/sh/table_consistent_check_public.sh $do_date ods_order_refund_info id,user_id,order_id,sku_id,refund_type,refund_num,refund_amount,refund_reason_type,create_time dwd_fact_order_refund_info id,user_id,order_id,sku_id,refund_type,refund_num,refund_amount,refund_reason_type,create_time

/opt/module/data_check/sh/table_consistent_check_public.sh $do_date ods_comment_info id,user_id,sku_id,spu_id,order_id,appraise,create_time dwd_fact_comment_info id,user_id,sku_id,spu_id,order_id,appraise,create_time

/opt/module/data_check/sh/table_consistent_check_public.sh $do_date ods_cart_info id,user_id,sku_id,cart_price,sku_num,sku_name,create_time,operate_time,is_ordered,order_time dwd_fact_cart_info id,user_id,sku_id,cart_price,sku_num,sku_name,create_time,operate_time,is_ordered,order_time

/opt/module/data_check/sh/table_consistent_check_public.sh $do_date ods_favor_info id,user_id,sku_id,spu_id,is_cancel,create_time,cancel_time dwd_fact_favor_info id,user_id,sku_id,spu_id,is_cancel,create_time,cancel_time
