//
//  JSLPublishNotesModel.swift
//  JSLogistics
//  首页发布笔记 model
//  Created by gouyz on 2019/11/6.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLPublishNotesModel: LHSBaseModel {
    /// 笔记id
    var publish_id : String? = ""
    /// 用户id
    var user_id : String? = ""
    /// 内容
    var content : String? = ""
    /// 图片
    var img : String? = ""
    /// 标题
    var title : String? = ""
    /// 点赞数
    var point_count : String? = ""
    /// 是否点赞：0：未点赞；1:已点赞
    var is_point : String? = ""
    /// 用户信息
    var userInfoModel : JSLUserInfoModel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "userInfo"{
            guard let datas = value as? [String : Any] else { return }
            userInfoModel = JSLUserInfoModel(dict: datas)
        }else {
            super.setValue(value, forKey: key)
        }
    }
}
