//
//  JSLFollowMsgModel.swift
//  JSLogistics
//  关注消息model
//  Created by gouyz on 2019/11/11.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLFollowMsgModel: LHSBaseModel {

    ///
    var id : String? = ""
    ///
    var user_id : String? = ""
    /// 关注用户id
    var concern_user_id : String? = ""
    ///
    var publish_id : String? = ""
    /// 说明
    var desc : String? = ""
    ///
    var add_time : String? = ""
    ///
    var status : String? = ""
    /// 用户信息
    var userInfoModel : JSLUserInfoModel?
    /// 笔记信息
    var publishInfoModel: JSLPublishNotesModel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "userInfo"{
            guard let datas = value as? [String : Any] else { return }
            userInfoModel = JSLUserInfoModel(dict: datas)
        }else if key == "publishInfo"{
            guard let datas = value as? [String : Any] else { return }
            userInfoModel = JSLUserInfoModel(dict: datas)
        }else {
            super.setValue(value, forKey: key)
        }
    }
}
