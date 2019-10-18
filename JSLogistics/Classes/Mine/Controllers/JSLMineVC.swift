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

class JSLMineVC: GYZBaseVC {
    
    var segmentedViewDataSource: JXSegmentedTitleDataSource!
    let JXTableHeaderViewHeight: Int = 220
    let titles = ["我的笔记(88)", "我的收藏(88)"]
    
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
        let vc = JSLHomeListVC()
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
