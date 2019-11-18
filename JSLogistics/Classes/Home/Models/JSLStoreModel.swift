//
//  JSLStoreModel.swift
//  JSLogistics
//  店铺信息 model 
//  Created by gouyz on 2019/11/14.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLStoreModel: LHSBaseModel {

    /// id
    var store_id : String? = ""
    /// 店铺名称
    var store_name : String? = ""
    /// 店铺logo
    var store_logo : String? = ""
    /// 地址
    var address : String? = ""
    /// 商家电话
    var store_phone : String? = ""
    /// 店铺指数
    var store_exponent : String? = ""
    /// 店铺标签
    var store_tag : String? = ""
    /// 人均消费
    var store_consume : String? = ""
    /// 店铺背景
    var store_banner : String? = ""
    /// 经度
    var longitude : String? = ""
    /// 纬度
    var latitude : String? = ""
}
