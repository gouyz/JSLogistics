//
//  JSLGoodsModel.swift
//  JSLogistics
//  商品model
//  Created by gouyz on 2019/11/6.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLGoodsModel: LHSBaseModel {

    /// id
    var goods_id : String? = ""
    /// 商品名称
    var goods_name : String? = ""
    /// 出售价
    var shop_price : String? = "0"
    /// 原价
    var market_price : String? = "0"
    /// 订单里的商品价格
    var goods_price : String? = "0"
    /// 店铺id
    var store_id : String? = ""
    /// 图片
    var original_img : String? = ""
    /// 店铺名称
    var store_name : String? = ""
    /// 地址
    var address : String? = ""
    /// 距离
    var distance : String? = ""
    /// 菜单
    var goods_content : String? = ""
    /// 图片
    var imgList : [String] = [String]()
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "img"{
            guard let datas = value as? [String] else { return }
            for item in datas {
                imgList.append(item)
            }
        }else {
            super.setValue(value, forKey: key)
        }
    }
}
