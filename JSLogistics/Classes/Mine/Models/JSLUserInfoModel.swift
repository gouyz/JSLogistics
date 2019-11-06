//
//  JSLUserInfoModel.swift
//  JSLogistics
//  用户信息 model
//  Created by gouyz on 2019/11/6.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLUserInfoModel: LHSBaseModel {

    /// 用户id
    var user_id : String? = ""
    /// 性别
    var sex : String? = ""
    /// 昵称
    var nickname : String? = ""
    ///
    var mobile : String? = ""
    /// 
    var email : String? = ""
    ///
    var birthday : String? = ""
    /// 头像
    var head_pic : String? = ""
    /// 省份
    var province : String? = ""
    /// 市
    var city : String? = ""
    /// 区县
    var district : String? = ""
    /// 介绍
    var introduction : String? = ""
    /// 图集
    var imgList: [String] = [String]()
    
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
