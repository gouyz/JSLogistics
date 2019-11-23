//
//  JSLMineVC.swift
//  JSLogistics
//  我的
//  Created by gouyz on 2019/8/7.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import JXSegmentedView
import JXPagingView
import MBProgressHUD

class JSLMineVC: GYZBaseVC {
    
    var segmentedViewDataSource: JXSegmentedTitleDataSource!
    let JXTableHeaderViewHeight: Int = 220
    var titles: [String] = ["我的笔记(0)", "我的收藏(0)"]
    
    var userInfoModel: JSLMineInfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_shared")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedSharedBtn))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_setting")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedSettingBtn))
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.addSubview(pagingView)
        pagingView.snp.makeConstraints { (make) in
            make.top.equalTo(kTitleAndStateHeight)
            make.left.right.bottom.equalTo(self.view)
        }
        
        segmentedView.contentScrollView = pagingView.listContainerView.collectionView
        
        headerView.didSelectItemBlock = {[unowned self](index) in
            self.clickedOperator(index: index)
        }
        
        requestMineInfo()
    }
    lazy var pagingView: JXPagingView = {
        let pageView = JXPagingListRefreshView(delegate: self) //JXPagingView.init(delegate: self)
        
        return pageView
    }()
    lazy var segmentedView: JXSegmentedView = {
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedViewDataSource = JXSegmentedTitleDataSource()
        segmentedViewDataSource.isTitleColorGradientEnabled = true
        segmentedViewDataSource.titleNormalColor = kBlackFontColor
        segmentedViewDataSource.titleSelectedColor = kGreenFontColor
        segmentedViewDataSource.titles = titles
        //reloadData(selectedIndex:)一定要调用
        segmentedViewDataSource.reloadData(selectedIndex: 0)
        //配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.indicatorColor = kGreenFontColor
        
        let segView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kTitleHeight))
        segView.delegate = self
        segView.backgroundColor = kWhiteColor
        segView.dataSource = segmentedViewDataSource
        segView.indicators = [indicator]
        
        return segView
    }()
    lazy var headerView: JSLMineHeaderView = JSLMineHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: CGFloat(JXTableHeaderViewHeight)))
    
    //我的
    func requestMineInfo(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("user/myIndex", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? ""],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
        
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].dictionaryObject else { return }
                weakSelf?.userInfoModel = JSLMineInfoModel.init(dict: data)
                weakSelf?.dealData()
            
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    func dealData(){
        if userInfoModel != nil {
            headerView.dataModel = userInfoModel
            titles = ["我的笔记(\((userInfoModel?.my_publish)!))", "我的收藏(\((userInfoModel?.my_collect)!))"]
            reloadData()
        }
    }
    func reloadData() {
        //一定要统一segmentedDataSource、segmentedView、listContainerView的defaultSelectedIndex
        segmentedViewDataSource.titles = titles
        //reloadData(selectedIndex:)一定要调用
        segmentedViewDataSource.reloadData(selectedIndex: 0)
        
        segmentedView.defaultSelectedIndex = 0
        segmentedView.reloadData()
        
        pagingView.defaultSelectedIndex = 0
        pagingView.reloadData()
    }
    /// 分享
    @objc func clickedSharedBtn(){
        
    }
    /// 设置
    @objc func clickedSettingBtn(){
        let vc = JSLSettingVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 操作
    func clickedOperator(index:Int){
        switch index {
        case 101:/// 我的粉丝
            goMyFensi()
        case 102:/// 我的关注
            goMyFollow()
        case 103:
            break
        case 104:
            break
        case 105: /// 我的虚拟币
            goMyMoney()
        case 107:/// 我的订单
            showOrderView(isConment: false)
        case 106:/// 我的评论
            showOrderView(isConment: true)
        case 108:/// 我的资料
            goMyProfile()
        default:
            break
        }
    }
    
    func goLogin(){
        let navVC = GYZBaseNavigationVC(rootViewController:JSLLoginVC())
        
        self.present(navVC, animated: true, completion: nil)
    }
    /// 我的粉丝
    func goMyFensi(){
        let vc = JSLMyFenSiVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 我的关注
    func goMyFollow(){
        let vc = JSLMyFollowVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 我的虚拟币
    func goMyMoney(){
        let vc = JSLXuniMoneyVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 评论
    func goMyConment(type: String){
        let vc = JSLMyConmentVC()
        vc.orderType = type
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 我的资料
    func goMyProfile(){
        let vc = JSLMyProfileVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 我的订单
    func showOrderView(isConment: Bool){
        let alertView = JSLCustomOrderView()
        if isConment {
            alertView.cartOrderBtn.set(image: UIImage.init(named: "icon_gouwu_order"), title: "购物评论", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
            alertView.chuxingOrderBtn.set(image: UIImage.init(named: "icon_chuxing_order"), title: "出行评论", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        }
        alertView.action = {[unowned self] (alert,index) in
            self.gotoDeal(index: index,isConment: isConment)
        }
        alertView.show()
    }
    
    func gotoDeal(index: Int,isConment: Bool){
        if isConment {
            if index == 101 {// 购物评论
                goMyConment(type: "1")
            }else{// 出行评论
                goMyConment(type: "2")
            }
        }else{
            if index == 101 {// 购物订单
                let vc = JSLCartOrderVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }else{// 出行订单
                let vc = JSLTripOrderVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}
extension JSLMineVC: JXPagingViewDelegate {
    
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return JXTableHeaderViewHeight
    }
    
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return headerView
    }
    
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return Int(kTitleHeight)
    }
    
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentedView
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return titles.count
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        let vc = JSLMyPublishNotesVC()
        vc.type = "\(index)"
        return vc
    }
    
}

extension JSLMineVC: JXSegmentedViewDelegate {
    //    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
    //
    //        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    //    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        self.pagingView.listContainerView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
    }
}
