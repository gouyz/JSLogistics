//
//  JSLCommonNavVC.swift
//  JSLogistics
//
//  Created by gouyz on 2019/8/9.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD

class JSLCommonNavVC: GYZBaseVC {
    
    /// 0：没有权限；1：有
    var isAppoint: String = "0"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "即时美食"
        self.navigationController?.navigationBar.isTranslucent = false
        let rightBtn = UIButton(type: .custom)
        rightBtn.titleLabel?.font = k13Font
        rightBtn.setTitleColor(kBlackFontColor, for: .normal)
        rightBtn.frame = CGRect.init(x: 0, y: 0, width: 80, height: kTitleHeight)
        rightBtn.set(image: UIImage.init(named: "icon_home_car"), title: "出行&物流", titlePosition: .right, additionalSpacing: 5, state: .normal)
        rightBtn.addTarget(self, action: #selector(onClickedRightBtn), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        rightBtn.sizeToFit() // 解决iOS11以下，显示不全
        
        let leftBtn = UIButton(type: .custom)
        leftBtn.titleLabel?.font = k13Font
        leftBtn.setTitleColor(kBlackFontColor, for: .normal)
        leftBtn.frame = CGRect.init(x: 0, y: 0, width: 80, height: kTitleHeight)
        leftBtn.set(image: UIImage.init(named: "icon_home_address"), title: "常州", titlePosition: .right, additionalSpacing: 5, state: .normal)
        leftBtn.addTarget(self, action: #selector(onClickedLeftBtn), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
        leftBtn.sizeToFit() // 解决iOS11以下，显示不全
    }
    
    /// 出行&物流
    @objc func onClickedRightBtn(){
        if isAppoint == "1" {
            let vc = JSLAppointCarVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            MBProgressHUD.showAutoDismissHUD(message: "暂无出行权限")
        }
        
    }
    /// 城市
    @objc func onClickedLeftBtn(){
        let vc = JSLSelectCityVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //出行权限
    func requestIsAppoint(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("user/is_appoint", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? ""],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
        
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                weakSelf?.isAppoint = response["result"].stringValue
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
}
