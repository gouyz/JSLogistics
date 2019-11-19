//
//  JSLCreateOrderModel.swift
//  JSLogistics
//  提交订单model
//  Created by gouyz on 2019/11/19.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLCreateOrderModel: LHSBaseModel {

    /// 商品信息
    var goodsInfo: JSLGoodsModel?
    /// 店铺信息
    var storeInfo: JSLStoreModel?
    /// 虚拟币
    var user_money: String? = "0"
    
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
