//
//  JSLTripOrderModel.swift
//  JSLogistics
//  出行订单 model
//  Created by gouyz on 2019/11/22.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLTripOrderModel: LHSBaseModel {

    /// 订单id
    var appoint_id: String? = ""
    /// 订单编号
    var order_sn: String? = ""
    ///
    var user_id: String? = ""
    /// 订单状态0：待出行；1：待评价；2：已完成；3：已取消
    var status: String? = "0"
    /// 出发地
    var departure: String? = "0"
    /// 目的地
    var destination: String? = "0"
    /// 预约出发时间
    var time: String? = "0"
    /// 金额
    var money: String? = "0"
    /// 距离
    var distance: String? = "0"
    /// 下单时间
    var add_time: String? = "0"
    ///
    var is_plan: String? = ""
    /// 状态名称
    var status_name: String? = ""
}
