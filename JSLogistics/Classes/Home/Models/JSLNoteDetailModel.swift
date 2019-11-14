//
//  JSLNoteDetailModel.swift
//  JSLogistics
//  笔记详情 model
//  Created by gouyz on 2019/11/14.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLNoteDetailModel: LHSBaseModel {
    
    /// 评论数
    var comment_count : String? = "0"
    /// 点赞数
    var point_count : String? = "0"
    /// 是否点赞：1：点赞；0：未点赞
    var is_point : String? = "0"
    /// 是否关注  0：未关注；1：关注
    var is_concern : String? = "0"
    /// 收藏数
    var collect_count : String? = "0"
    /// 是否收藏：0：未收藏；1：收藏
    var is_collect : String? = "0"
    /// 是否有预约车的权限：0：否；1：是
    var is_appoint : String? = "0"

    /// 用户信息
    var userInfoModel : JSLUserInfoModel?
    /// 商品信息
    var goodsInfo: JSLGoodsModel?
    /// 店铺信息
    var storeInfo: JSLStoreModel?
    /// 发布笔记信息
    var publishInfo: JSLPublishInfoModel?
    ///  评论列表
    var conmentList: [JSLConmentModel] = [JSLConmentModel]()
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "userInfo"{
            guard let datas = value as? [String:Any] else { return }
            userInfoModel = JSLUserInfoModel.init(dict: datas)
        }else if key == "publishInfo"{
            guard let datas = value as? [String:Any] else { return }
            publishInfo = JSLPublishInfoModel.init(dict: datas)
        }else if key == "goodsInfo"{
            guard let datas = value as? [String:Any] else { return }
            goodsInfo = JSLGoodsModel.init(dict: datas)
        }else if key == "store_info"{
            guard let datas = value as? [String:Any] else { return }
            storeInfo = JSLStoreModel.init(dict: datas)
        }else if key == "commentList"{
            guard let datas = value as? [[String:Any]] else { return }
            for item in datas {
                let model = JSLConmentModel(dict: item)
                conmentList.append(model)
            }
        }else {
            super.setValue(value, forKey: key)
        }
    }
}
