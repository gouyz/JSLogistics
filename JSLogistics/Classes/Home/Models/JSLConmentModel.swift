//
//  JSLConmentModel.swift
//  JSLogistics
//  评论 model
//  Created by gouyz on 2019/11/14.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLConmentModel: LHSBaseModel {

    /// id
    var comment_id : String? = ""
    /// 笔记id
    var publish_id : String? = ""
    /// 评论人id
    var user_id : String? = ""
    /// 评论人名称
    var username : String? = ""
    /// 头像
    var head : String? = ""
    /// 内容
    var content : String? = ""
    ///
    var comm_point : String? = "0"
    /// 评论日期
    var add_time : String? = ""
}
