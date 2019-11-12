//
//  JSLFavouriteMsgModel.swift
//  JSLogistics
//  赞和收藏model
//  Created by gouyz on 2019/11/12.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLFavouriteMsgModel: LHSBaseModel {

    ///
    var id : String? = ""
    ///
    var user_id : String? = ""
    /// 发布用户id
    var publish_user_id : String? = ""
    /// 笔记id
    var publish_id : String? = ""
    ///
    var add_time : String? = ""
    ///
    var status : String? = ""
    /// 收藏了你的美食笔记
    var desc : String? = ""
    ///
    var img : String? = ""
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
