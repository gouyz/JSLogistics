//
//  JSLXuniMoneyModel.swift
//  JSLogistics
//  虚拟币明细model
//  Created by gouyz on 2019/11/23.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLXuniMoneyModel: LHSBaseModel {

    /// id
    var log_id: String? = ""
    /// 订单编号
    var order_sn: String? = ""
    ///
    var user_id: String? = ""
    /// 数量
    var user_money: String? = "0"
    /// 说明
    var desc: String? = ""
    /// 时间
    var change_time: String? = ""
    ///
    var order_id: String? = ""
}
