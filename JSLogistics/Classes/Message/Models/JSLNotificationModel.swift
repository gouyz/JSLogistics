//
//  JSLNotificationModel.swift
//  JSLogistics
//  通知消息model
//  Created by gouyz on 2019/11/11.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLNotificationModel: LHSBaseModel {

    ///
    var id : String? = ""
    ///
    var user_id : String? = ""
    ///
    var publish_id : String? = ""
    /// 通知描述
    var desc : String? = ""
    ///
    var add_time : String? = ""
    ///
    var status : String? = ""
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
