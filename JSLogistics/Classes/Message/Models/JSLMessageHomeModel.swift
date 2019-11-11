//
//  JSLMessageHomeModel.swift
//  JSLogistics
//  消息首页 model
//  Created by gouyz on 2019/11/11.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLMessageHomeModel: LHSBaseModel {

    /// 通知信息
    var notificationModel : JSLNotificationModel?
    /// 关注信息
    var followMsgModel : JSLConcernMsgModel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "notice"{
            guard let datas = value as? [String : Any] else { return }
            notificationModel = JSLNotificationModel(dict: datas)
        }else if key == "concern"{
            guard let datas = value as? [String : Any] else { return }
            followMsgModel = JSLConcernMsgModel(dict: datas)
        } else {
            super.setValue(value, forKey: key)
        }
    }
}
@objcMembers
class JSLConcernMsgModel: LHSBaseModel {

    /// 关注用户id
    var concern_user_id : String? = ""
    /// 说明
    var desc : String? = ""
    ///
    var add_time : String? = ""
    /// 关注用户昵称
    var concern_nickname : String? = ""
}
