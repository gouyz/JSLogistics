//
//  JSLMyProfilePhotoModel.swift
//  JSLogistics
//  我的 编辑图片model
//  Created by gouyz on 2019/11/24.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLMyProfilePhotoModel: LHSBaseModel {

    ///
    var imgURL: String? = ""
    /// 订单编号
    var img: UIImage?
    /// 0本地图片1网络图片
    var isUrl: String? = ""
}
