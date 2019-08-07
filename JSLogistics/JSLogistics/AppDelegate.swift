//
//  AppDelegate.swift
//  JSLogistics
//
//  Created by gouyz on 2019/8/6.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// 检测网络状态
        networkManager?.startListening()
        
        /// 设置键盘控制
        setKeyboardManage()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = kWhiteColor
        
        //如果未登录进入登录界面，登录后进入首页
//        if userDefaults.bool(forKey: kIsLoginTagKey) {
//            let menuContrainer = FWSideMenuContainerViewController.container(centerViewController: GYZMainTabBarVC(), centerLeftPanViewWidth: 20, centerRightPanViewWidth: 20, leftMenuViewController: HOOPLeftMenuVC(), rightMenuViewController: nil)
//            menuContrainer.leftMenuWidth = kLeftMenuWidth
//
//            window?.rootViewController = menuContrainer
//
//        }else{
//            window?.rootViewController = GYZBaseNavigationVC(rootViewController: HOOPRegisterFirstVC())
//        }
        window?.rootViewController = GYZBaseNavigationVC(rootViewController: GYZMainTabBarVC())
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    /// 设置键盘控制
    func setKeyboardManage(){
        //控制自动键盘处理事件在整个项目内是否启用
        IQKeyboardManager.shared.enable = true
        //点击背景收起键盘
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        //隐藏键盘上的工具条(默认打开)
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
}

