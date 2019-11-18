//
//  JSLStoreDetailModel.swift
//  JSLogistics
//  店铺详情
//  Created by gouyz on 2019/11/18.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

@objcMembers
class JSLStoreDetailModel: LHSBaseModel {

    /// 是否有预约车的权限：0：否；1：是
    var is_appoint : String? = "0"
    /// 商品信息list
    var goodsList: [JSLGoodsModel] = [JSLGoodsModel]()
    /// 店铺信息
    var storeInfo: JSLStoreModel?
    /// 笔记列表
    var publishList: [JSLPublishNotesModel] = [JSLPublishNotesModel]()
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "goodsList"{
            guard let datas = value as? [[String:Any]] else { return }
            for item in datas {
                let model = JSLGoodsModel(dict: item)
                goodsList.append(model)
            }
        }else if key == "storeInfo"{
            guard let datas = value as? [String:Any] else { return }
            storeInfo = JSLStoreModel.init(dict: datas)
        }else if key == "publishList"{
            guard let datas = value as? [[String:Any]] else { return }
            for item in datas {
                let model = JSLPublishNotesModel(dict: item)
                publishList.append(model)
            }
        }else {
            super.setValue(value, forKey: key)
        }
    }
}
