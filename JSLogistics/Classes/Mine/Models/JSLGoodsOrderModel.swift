//
//  JSLGoodsOrderModel.swift
//  JSLogistics
//  购物订单 model
//  Created by gouyz on 2019/11/21.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLGoodsOrderModel: LHSBaseModel {

    /// 商品信息
    var goodsInfo: JSLGoodsModel?
    /// 店铺信息
    var storeInfo: JSLStoreModel?
    /// 订单id
    var order_id: String? = ""
    /// 订单编号
    var order_sn: String? = ""
    ///
    var user_id: String? = ""
    /// 订单状态1：待使用；2：待评价；3：已取消；4：已完成
    var order_status: String? = "0"
    /// 是否支付：0：否；1：是
    var pay_status: String? = "0"
    /// 是否评价：0：否；1：是
    var is_comment: String? = "0"
    /// 虚拟币抵用的钱
    var user_money: String? = "0"
    /// 应付的钱
    var order_amount: String? = "0"
    /// 订单总额
    var total_amount: String? = "0"
    /// 下单时间
    var add_time: String? = "0"
    /// 商家id
    var store_id: String? = ""
    /// 状态名称
    var status_name: String? = ""
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "goodsInfo"{
            guard let datas = value as? [String:Any] else { return }
            goodsInfo = JSLGoodsModel.init(dict: datas)
        }else if key == "storeInfo"{
            guard let datas = value as? [String:Any] else { return }
            storeInfo = JSLStoreModel.init(dict: datas)
        }else {
            super.setValue(value, forKey: key)
        }
    }
}
