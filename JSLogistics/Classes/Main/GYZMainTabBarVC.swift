//
//  GYZMainTabBarVC.swift
//  baking
//  底部导航控制器
//  Created by gouyz on 2017/3/23.
//  Copyright © 2017年 gouyz. All rights reserved.
//

import UIKit

class GYZMainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        setUp()
    }
    
    func setUp(){
        tabBar.tintColor = kBlackFontColor
        /// 解决iOS12.1 子页面返回时底部tabbar出现了错位
        tabBar.isTranslucent = false
        
        addViewController(JSLHomeVC(), title: "首页", normalImgName: "icon_tabbar_home", tag: 0)
        addViewController(JSLShopVC(), title: "探店", normalImgName: "icon_tabbar_shop", tag: 1)
        addViewController(JSLPublishVC(), title: "", normalImgName: "icon_tabbar_publish", tag: 2)
        addViewController(JSLMessageVC(), title: "消息", normalImgName: "icon_tabbar_msg", tag: 3)
        addViewController(JSLMineVC(), title: "我的", normalImgName: "icon_tabbar_mine", tag: 4)
        
    }
    override var shouldAutorotate: Bool{
        return self.selectedViewController?.shouldAutorotate ?? false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 添加子控件
    fileprivate func addViewController(_ childController: UIViewController, title: String,normalImgName: String, tag: Int) {
        let nav = GYZBaseNavigationVC.init(rootViewController: childController)
        addChild(nav)
        childController.tabBarItem.tag = tag
        childController.tabBarItem.title = title
        // 设置 tabbarItem 选中状态的图片(不被系统默认渲染,显示图像原始颜色)
        childController.tabBarItem.image = UIImage(named: normalImgName)?.withRenderingMode(.alwaysOriginal)
        if title == "" {// 发布
            childController.tabBarItem.imageInsets = UIEdgeInsets.init(top: -5, left: 0, bottom: 5, right: 0)
            childController.tabBarItem.selectedImage = UIImage(named: normalImgName)?.withRenderingMode(.alwaysOriginal)
        }else{
            childController.tabBarItem.selectedImage = UIImage(named: normalImgName + "_selected")?.withRenderingMode(.alwaysOriginal)
        }
    }
}
extension GYZMainTabBarVC: UITabBarControllerDelegate{
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        /// 当选中发布、我的的时候，要判断是否登录
        if viewController.tabBarItem.tag == 2 ||  viewController.tabBarItem.tag == 4{
            
            if userDefaults.bool(forKey: kIsLoginTagKey){
                return true
            }
            let vc = JSLLoginVC()
            //登录成功的回调
            vc.resultBlock = {[weak self] in
                self?.selectedIndex = viewController.tabBarItem.tag
            }
            let navVC = GYZBaseNavigationVC(rootViewController:vc)
            
            if let nc = tabBarController.selectedViewController as? GYZBaseNavigationVC {
                nc.present(navVC, animated: true, completion: nil)
            }
            return false
        }
        
        return true
    }
}
