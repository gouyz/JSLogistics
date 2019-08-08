//
//  GYZConst.swift
//  flowers
//  常量及共用方法定义
//  Created by gouyz on 2016/11/4.
//  Copyright © 2016年 gouyz. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


// keyWindow
let KeyWindow : UIWindow = UIApplication.shared.keyWindow!

/// 屏幕的宽
let kScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕的高
let kScreenHeight = UIScreen.main.bounds.size.height

/// 间距
let kMargin: CGFloat = 10.0
/// 圆角
let kCornerRadius: CGFloat = 5.0
/// 线宽
let klineWidth: CGFloat = 0.5
/// 双倍线宽
let klineDoubleWidth: CGFloat = 1.0
/// 状态栏高度
let kStateHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height
/// 标题栏高度
let kTitleHeight : CGFloat = 44.0
/// 状态栏和标题栏高度
let kTitleAndStateHeight : CGFloat = kStateHeight + kTitleHeight
/// 底部导航栏高度
let kTabBarHeight: CGFloat = kStateHeight > 20.0 ? 83.0 : 49.0
/// 底部按钮高度
let kBottomTabbarHeight : CGFloat = 49.0

/// 按钮高度
let kUIButtonHeight : CGFloat = 44.0

////sheetView 常量定义
///分割线高度
let kLineHeight : CGFloat = 0.5
/// 间距
let kSheetMargin: CGFloat = 6.0
/// sheetView cell高度
let kCellH : CGFloat = 45
/// sheetView 最大高度
let kSheetViewMaxH : CGFloat = kScreenHeight * 0.7
/// sheetView 宽度
let kSheetViewWidth  = kScreenWidth - kSheetMargin * 2
/// 消失动画时间
let kDismissTime = 0.3
/// 显示动画时间
let kPushTime = 0.3
/// 右侧箭头大小
let rightArrowSize: CGSize = CGSize.init(width: 8, height: 13)

/// alertViewController 取消的回调返回的索引
let cancelIndex = -1

/////4列，列间隔为10，距离屏幕边距左右各10
let kPhotosImgHeight: CGFloat = (kScreenWidth - 50)/4.0
/////3列，列间隔为10，距离屏幕边距右10,左50
let kPhotosImgHeight4Processing: CGFloat = (kScreenWidth - 80)/3.0
/////3列，列间隔为10，距离屏幕边距右10,左60
let kPhotosImgHeight4Comment: CGFloat = (kScreenWidth - 90)/3.0
/// 最大上传图片张数
let kMaxSelectCount = 9

/// 记录版本号的key
let LHSBundleShortVersionString = "LHSBundleShortVersionString"
/// 是否登录标识
let kIsLoginTagKey = "loginTag"

/// 保存异常信息标识
let ERROR_MESSAGE = "ERROR_MESSAGE"

///已读消息后，刷新消息角标 通知名称
let kUMessageBadageRefreshData = "messageBadageRefreshData"
/// 极光推送 跳转指定页面通知名称
let kJPushRefreshData = "kJPushRefreshData"

/// 存储用户信息的key
let USERINFO = "userInfo"
/// 存储所有城市信息的key
let ALLCITYINFO = "allCityInfo"
/// 存储当前城市信息的key
let CURRCITYINFO = "currCityInfo"
/// 存储当前城市当前区县信息的key
let CURRCITYAREAINFO = "currCityAreaInfo"
//API APPID
let API_APPID = "16"
//API API_APPKEY
let API_APPKEY = "afc9991110766bd842da8380112bb086"
//API SECRET_KEY
let API_SECRET_KEY = "fee3700210e291eafea794a26a486db9"

//APPID，应用提交时候替换
let APPID = "1441962604"
/// 极光推送AppKey
let kJPushAppKey = "62ef6e1984206705e1aca538"

/// 无网络提示
let kNoNetWork = "当前网络不可用，请检查网络情况"

/// 数据返回的分页数量
let kPageSize = 20
/// 网络数据请求成功标识
let kQuestSuccessTag = 1

/// 字体常量
let k10Font = UIFont.systemFont(ofSize: 10.0)
let k12Font = UIFont.systemFont(ofSize: 12.0)
let k13Font = UIFont.systemFont(ofSize: 13.0)
let k14Font = UIFont.systemFont(ofSize: 14.0)
let k15Font = UIFont.systemFont(ofSize: 15.0)
let k18Font = UIFont.systemFont(ofSize: 18.0)
let k20Font = UIFont.systemFont(ofSize: 20.0)

let userDefaults = UserDefaults.standard

///颜色常量

/// 通用背景颜色
let kBackgroundColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0xf8f8f8)
/// 蓝色通用背景颜色
let kBlueBackgroundColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0x72bce4)
/// 导航栏背景颜色
let kNavBarColor : UIColor = UIColor.white
/// 黑色字体颜色
let kBlackFontColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0x333333)
/// 深灰色字体颜色
let kHeightGaryFontColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0x999999)
/// 灰色字体颜色
let kGaryFontColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0xaeaeae)
/// 黄色字体颜色
let kYellowFontColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0xf7a870)
/// 橙色字体颜色
let kOrangeFontColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0xf38053)
/// 浅灰色字体颜色
let kLightGaryFontColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0xdcdcdc)
/// 红色字体颜色
let kRedFontColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0xfb0d1b)
/// 蓝色字体颜色
let kBlueFontColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0x39befc)
/// 绿色字体颜色
let kGreenFontColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0x6fdcdc)
/// 灰色线的颜色
let kGrayLineColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0xe4e4e4)
/// 灰色背景的颜色
let kGrayBackGroundColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0xf5f5f5)
/// btn不可点击背景色
let kBtnNoClickBGColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0xf5f5f5)
/// btn可点击背景色
let kBtnClickBGColor : UIColor = kYellowFontColor
/// btn可点击浅绿色背景色
let kBtnClickLightGreenColor : UIColor = UIColor.UIColorFromRGB(valueRGB: 0x36dbc0)
/// 系统白色
let kWhiteColor : UIColor = UIColor.white
/// 系统黑色
let kBlackColor : UIColor = UIColor.black

/// 网络监听
let networkManager = NetworkReachabilityManager.init(host: "www.apple.com")

/// 根据版本号来确定是否进入新特性界面
///
/// - returns: true/false
func newFeature() -> Bool {
    
    /// 获取当前版本号
    let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    
    let oldVersion = userDefaults.object(forKey: LHSBundleShortVersionString) ?? ""
    
    if currentVersion.compare(oldVersion as! String) == .orderedDescending{
        
        userDefaults.set(currentVersion, forKey: LHSBundleShortVersionString)
        return true
    }
    return false
}
///手机号码区段
let PHONECODE:[String] = ["+86","+852","+853","+886"]
//////////    分享数据
/// 微信好友
let kWXFriendShared = "wxfriend"
/// 微信朋友圈
let kWXMomentShared = "wxmoment"
/// QQ好友
let kQQFriendShared = "qqfriend"
/// QQ空间
let kQZoneShared = "qzone"

let kSharedCards = [
    [
        [
            "title": "微信好友",
            "icon": "icon_wechat",
            "handler": kWXFriendShared
        ],[
            "title": "微信朋友圈",
            "icon": "icon_wechat_circle",
            "handler": kWXMomentShared
        ],[
            "title": "QQ好友",
            "icon": "icon_qq",
            "handler": kQQFriendShared
        ],[
            "title": "QQ空间",
            "icon": "icon_qzone",
            "handler": kQZoneShared
        ]
    ]
]

/****** 自定义Log ******/
func GYZLog<T>(_ message: T, fileName: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
        let filename = (fileName as NSString).pathComponents.last
        print("\(filename!)\(function)[\(lineNumber)]: \(message)")
    #endif
}
