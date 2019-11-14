//
//  JSLPublishInfoModel.swift
//  JSLogistics
//  发布笔记model
//  Created by gouyz on 2019/11/14.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLPublishInfoModel: LHSBaseModel {

    /// 笔记id
    var publish_id : String? = ""
    /// 用户id
    var user_id : String? = ""
    /// 店铺id
    var store_id : String? = ""
    /// type id
    var type_id : String? = ""
    /// 内容
    var content : String? = ""
    /// 图片
    var imgList : [String] = [String]()
    /// 标题
    var title : String? = ""
    ///
    var status : String? = ""
    /// 美食标签
    var tagList : [String] = [String]()
    /// 推荐指数
    var exponent : String? = "0"
    ///
    var city : String? = ""
    /// 发布时间
    var publish_time : String? = ""
    ///
    var is_delete : String? = "0"
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "img"{
            guard let datas = value as? [String] else { return }
            for item in datas {
                imgList.append(item)
            }
        }else if key == "tag"{
            guard let datas = value as? [String] else { return }
            for item in datas {
                tagList.append(item)
            }
        }else {
            super.setValue(value, forKey: key)
        }
    }
}
