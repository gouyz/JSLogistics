//
//  GYZBaseVC.swift
//  flowers
//  基控制器
//  Created by gouyz on 2016/11/7.
//  Copyright © 2016年 gouyz. All rights reserved.
//  svn:
//  gouyongzheng
//  ab5!3U2|*rHwc`#F
//  apidoc:
//  413977349@qq.com
//  ysZ$BfI?94^rmO&a
//  svn地址：svn://106.15.95.95/tyapp
//  接口文档：http://apidoc.lijiayin.com/login.html
//  UI设计稿地址：https://lanhuapp.com/url/P8Hoi-6FV9A

import UIKit
import MBProgressHUD

class GYZBaseVC: UIViewController {
    
    var hud : MBProgressHUD?
//    var statusBarShouldLight = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = kBackgroundColor
        
        if navigationController?.children.count > 1 {
            // 添加返回按钮,不被系统默认渲染,显示图像原始颜色
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_back_black")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedBackBtn))
        }
        
    }
    
    /// 重载设置状态栏样式
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        if statusBarShouldLight {
//
//            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: kWhiteColor, NSAttributedString.Key.font: k18Font]
//
//            navigationController?.navigationBar.barTintColor = kNavBarColor
//            navigationController?.navigationBar.tintColor = kWhiteColor
//
//            return .lightContent
//        } else {
//
//            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: kBlackColor, NSAttributedString.Key.font: k18Font]
//
//            navigationController?.navigationBar.barTintColor = kWhiteColor
//            navigationController?.navigationBar.tintColor = kBlackColor
//
//            return .default
//        }
//    }

    /// 设置状态栏样式为default
//    func setStatusBarStyle(){
//
//        statusBarShouldLight = false
//        setNeedsStatusBarAppearanceUpdate()
//    }
    /// 返回
    @objc func clickedBackBtn() {
        _ = navigationController?.popViewController(animated: true)
    }
    /// 关闭屏幕旋转
    override var shouldAutorotate: Bool{
        return false
    }
    /// 创建HUD
    func createHUD(message: String){
        if hud != nil {
            hud?.hide(animated: true)
            hud = nil
        }
        
        hud = MBProgressHUD.showHUD(message: message,toView: view)
    }

}
