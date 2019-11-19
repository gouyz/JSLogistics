//
//  JSLGoodsDetailModel.swift
//  JSLogistics
//  商品详情 model
//  Created by gouyz on 2019/11/19.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLGoodsDetailModel: LHSBaseModel {

    /// 是否有预约车的权限：0：否；1：是
    var is_appoint : String? = "0"
    /// 商品信息
    var goodsInfo: JSLGoodsModel?
    /// 店铺信息
    var storeInfo: JSLStoreModel?
    
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
