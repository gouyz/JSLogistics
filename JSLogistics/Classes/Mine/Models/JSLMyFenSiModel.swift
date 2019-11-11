//
//  JSLMyFenSiModel.swift
//  JSLogistics
//  我的粉丝列表
//  Created by gouyz on 2019/11/11.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLMyFenSiModel: LHSBaseModel {

    /// 用户id
    var user_id : String? = ""
    /// 昵称
    var nickname : String? = ""
    /// 2篇美食笔记 1位粉丝
    var details : String? = ""
    /// 是否关注：0：否；1：是
    var is_concern : String? = ""
    /// 头像
    var head_pic : String? = ""
}
