#!/bin/bash
data_date=$1

# 增量检查
# 订单详情表
/opt/module/data_check/sh/increment_data_check_public.sh $data_date ods_order_detail id,order_id,user_id,sku_id,sku_name,order_price,sku_num,create_time
# 用户表
/opt/module/data_check/sh/increment_data_check_public.sh $data_date ods_user_info id,name,birthday,gender,email,user_level,create_time,operate_time
# 支付流水表
/opt/module/data_check/sh/increment_data_check_public.sh $data_date ods_payment_info id,out_trade_no,order_id,user_id,alipay_trade_no,total_amount,subject,payment_type,payment_time
# 订单状态表
/opt/module/data_check/sh/increment_data_check_public.sh $data_date ods_order_status_log id,order_id,order_status,operate_time
# 商品评论表
/opt/module/data_check/sh/increment_data_check_public.sh $data_date ods_comment_info id,user_id,sku_id,spu_id,order_id,appraise,create_time
# 退单表
/opt/module/data_check/sh/increment_data_check_public.sh $data_date ods_order_refund_info id,user_id,order_id,sku_id,refund_type,refund_num,refund_amount,refund_reason_type,create_time
# 活动订单关联表
/opt/module/data_check/sh/increment_data_check_public.sh $data_date ods_activity_order id,activity_id,order_id,create_time
# 全量检查
# 订单表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_order_info id,final_total_amount,order_status,user_id,out_trade_no,create_time,operate_time,province_id,benefit_reduce_amount,original_total_amount,feight_fee
# SKU商品表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_sku_info id,spu_id,price,sku_name,sku_desc,weight,tm_id,category3_id,create_time
# 商品一级分类表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_base_category1 id,name
# 商品二级分类表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_base_category2 id,name,category1_id
# 商品三级分类表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_base_category3 id,name,category2_id
# 品牌表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_base_trademark tm_id,tm_name
# SPU商品表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_spu_info id,spu_name,category3_id,tm_id
# 加购表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_cart_info id,user_id,sku_id,cart_price,sku_num,sku_name,create_time,operate_time,is_ordered,order_time
# 商品收藏表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_favor_info id,user_id,sku_id,spu_id,is_cancel,create_time,cancel_time
# 优惠券领用表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_coupon_use id,coupon_id,user_id,order_id,coupon_status,get_time,using_time,used_time
# 优惠券表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_coupon_info id,coupon_name,coupon_type,condition_amount,condition_num,activity_id,benefit_amount,benefit_discount,create_time,range_type,spu_id,tm_id,category3_id,limit_num,operate_time,expire_time
# 活动表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_activity_info id,activity_name,activity_type,start_time,end_time,create_time
# 优惠规则表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_activity_rule id,activity_id,condition_amount,condition_num,benefit_amount,benefit_discount,benefit_level
# 编码字典表
/opt/module/data_check/sh/total_data_check_public.sh $data_date ods_base_dic dic_code,dic_name,parent_code,create_time,operate_time

