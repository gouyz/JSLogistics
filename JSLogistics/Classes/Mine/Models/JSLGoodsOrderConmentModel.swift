//
//  JSLGoodsOrderConmentModel.swift
//  JSLogistics
//  购物订单评论详情
//  Created by gouyz on 2019/11/22.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLGoodsOrderConmentModel: LHSBaseModel {

    /// id
    var comment_id: String? = ""
    ///
    var goods_id: String? = ""
    ///
    var user_id: String? = ""
    /// 订单id
    var order_id: String? = ""
    /// 内容
    var content: String? = ""
    /// 时间
    var add_time: String? = ""
    /// 商家id
    var store_id: String? = ""
    /// 商品名称
    var goods_name: String? = ""
    /// 店铺名称
    var store_name: String? = ""
    /// 评论图片
    var imgList:[String] = [String]()
    /// 商品评分
    var goods_rank: String? = "0"
    /// 店铺评分
    var store_rank: String? = "0"
    /// 服务评分
    var service_rank: String? = "0"
    /// 用户信息
    var userInfoModel : JSLUserInfoModel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "img"{
            guard let datas = value as? [String] else { return }
            for item in datas {
                imgList.append(item)
            }
        }else if key == "userInfo"{
            guard let datas = value as? [String : Any] else { return }
            userInfoModel = JSLUserInfoModel(dict: datas)
        }else {
            super.setValue(value, forKey: key)
        }
    }
}
