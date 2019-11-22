//
//  JSLMyConmentVC.swift
//  JSLogistics
//  我的评价
//  Created by gouyz on 2019/10/30.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import JXSegmentedView

class JSLMyConmentVC: GYZBaseVC {
    
    var segmentedViewDataSource: JXSegmentedTitleDataSource!
    let titles = ["未评价", "已评价"]
    /// 1购物评论2出行评论
    var orderType:String = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的评价"
        
        self.view.addSubview(segmentedView)
        self.view.addSubview(listContainerView)
        segmentedView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(kTitleAndStateHeight)
            make.height.equalTo(kTitleHeight)
        }
        listContainerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(segmentedView.snp.bottom)
        }
        
        segmentedView.contentScrollView = listContainerView.scrollView
        
    }
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
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
        
        let segView = JXSegmentedView()
        segView.delegate = self
        segView.backgroundColor = kWhiteColor
        segView.dataSource = segmentedViewDataSource
        segView.indicators = [indicator]
        
        return segView
    }()
    
    
}
extension JSLMyConmentVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedViewDataSource.dataSource.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if orderType == "1" {// 购物评价
            let vc = JSLMyConmentListVC()
            vc.naviController = self.navigationController
            vc.type = index + 1
            return vc
        }else{//出行评价
            let vc = JSLMyAppointConmentVC()
            vc.naviController = self.navigationController
            vc.type = index + 1
            return vc
        }
    }
}

extension JSLMyConmentVC: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
        listContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        //传递scrollingFrom事件给listContainerView，必须调用！！！
        listContainerView.segmentedViewScrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex: segmentedView.selectedIndex)
    }
}
