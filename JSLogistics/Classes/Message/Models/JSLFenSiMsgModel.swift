//
//  JSLFenSiMsgModel.swift
//  JSLogistics
//  粉丝消息 model
//  Created by gouyz on 2019/11/12.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLFenSiMsgModel: LHSBaseModel {

    ///
    var id : String? = ""
    ///
    var user_id : String? = ""
    /// 关注用户id
    var concern_user_id : String? = ""
    /// 是否关注：0：否；1：是
    var is_concern : String? = "0"
    ///
    var add_time : String? = ""
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
