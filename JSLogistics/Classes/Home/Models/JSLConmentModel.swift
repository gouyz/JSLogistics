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
    
    var replyList: [JSLConmentReplyModel] = [JSLConmentReplyModel]()
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "reply_comment"{
            guard let datas = value as? [[String:Any]] else { return }
            for item in datas {
                let model = JSLConmentReplyModel(dict: item)
                replyList.append(model)
            }
        }else {
            super.setValue(value, forKey: key)
        }
    }
}


@objcMembers
class JSLConmentReplyModel: LHSBaseModel {

    /// id
    var id : String? = ""
    ///
    var parent_id : String? = ""
    /// 笔记id
    var publish_id : String? = ""
    /// 回复人的id
    var user_id : String? = ""
    /// 被回复人的id
    var reply_user_id : String? = ""
    /// 回复人的昵称
    var nickname : String? = ""
    /// 被回复人的昵称
    var rely_nickname : String? = ""
    /// 内容
    var content : String? = ""
    /// 回复人的头像
    var head_pic : String? = ""
    /// 评论日期
    var add_time : String? = ""
}
