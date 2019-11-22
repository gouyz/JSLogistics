//
//  JSLAppointOrderConmentModel.swift
//  JSLogistics
//  出行订单 评论详情model
//  Created by gouyz on 2019/11/22.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLAppointOrderConmentModel: LHSBaseModel {

    /// id
    var comment_id: String? = ""
    ///
    var user_id: String? = ""
    /// 内容
    var content: String? = ""
    /// 时间
    var add_time: String? = ""
    ///
    var appoint_id: String? = ""
    /// 评论图片
    var imgList:[String] = [String]()
    /// 司机评分
    var driver_rank: String? = "0"
    /// 环境评分
    var environment_rank: String? = "0"
    /// 服务评分
    var service_rank: String? = "0"
    /// 用户信息
    var userInfoModel : JSLUserInfoModel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "img"{
            guard let datas = value as? [String] else { return }
            for item in datas {
                imgList.append(item)
            }
        }else if key == "userInfo"{
            guard let datas = value as? [String : Any] else { return }
            userInfoModel = JSLUserInfoModel(dict: datas)
        }else {
            super.setValue(value, forKey: key)
        }
    }
}
