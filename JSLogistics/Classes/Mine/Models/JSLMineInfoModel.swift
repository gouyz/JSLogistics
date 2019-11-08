//
//  JSLMineInfoModel.swift
//  JSLogistics
//  我的主页 model
//  Created by gouyz on 2019/11/8.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLMineInfoModel: LHSBaseModel {

    /// 粉丝
    var ect_count : String? = "0"
    /// 关注
    var concern_count : String? = "0"
    /// 点赞
    var point_count : String? = "0"
    /// 收藏
    var collect_count : String? = "0"
    /// 我的笔记
    var my_publish : String? = "0"
    /// 我的收藏
    var my_collect : String? = "0"
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
