//
//  JSLShopVC.swift
//  JSLogistics
//  探店
//  Created by gouyz on 2019/8/7.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import JXSegmentedView
import JXPagingView
import MBProgressHUD
import PYSearch


private let searchShopHistoryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "PYSearchhistoriesShop.plist" // the path of search record cached

class JSLShopVC: JSLCommonNavVC {

    var segmentedViewDataSource: JXSegmentedTitleDataSource!
    let JXTableHeaderViewHeight: Int = Int(kTitleHeight)
    /// 分类
    var catrgoryList: [JSLGoodsCategoryModel] = [JSLGoodsCategoryModel]()
    var catrgoryNameList: [String] = [String]()
    var searchHotList: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pagingView)
        pagingView.snp.makeConstraints { (make) in
            //            make.top.equalTo(kTitleAndStateHeight)
            make.top.left.right.bottom.equalTo(self.view)
        }
        
        segmentedView.contentScrollView = pagingView.listContainerView.collectionView
        headerView.searchBtn.addTarget(self, action: #selector(onClickedSearch), for: .touchUpInside)
        
        requestCategoryList()
        requestHotSearchList()
    }
    
    lazy var pagingView: JXPagingView = {
        let pageView = JXPagingListRefreshView(delegate: self) //JXPagingView.init(delegate: self)
        
        return pageView
    }()
    lazy var segmentedView: JXSegmentedView = {
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedViewDataSource = JXSegmentedTitleDataSource()
        segmentedViewDataSource.isTitleColorGradientEnabled = false
        segmentedViewDataSource.isTitleMaskEnabled = true
        segmentedViewDataSource.titleNormalColor = kGaryFontColor
        segmentedViewDataSource.titleSelectedColor = kBlackFontColor
        segmentedViewDataSource.titles = catrgoryNameList
        //reloadData(selectedIndex:)一定要调用
        segmentedViewDataSource.reloadData(selectedIndex: 0)
        //配置指示器
        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.isIndicatorConvertToItemFrameEnabled = true
        indicator.indicatorHeight = 30
        indicator.indicatorColor = kBtnNoClickBGColor
        
        let segView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kTitleHeight))
        segView.delegate = self
        segView.backgroundColor = kWhiteColor
        segView.dataSource = segmentedViewDataSource
        segView.indicators = [indicator]
        
        return segView
    }()
    lazy var headerView: GYZSearchBtnView = GYZSearchBtnView.init(frame: CGRect.init(x: kMargin, y: 0, width: kScreenWidth - kMargin * 2, height: CGFloat(JXTableHeaderViewHeight)))
    
    ///获取发布分类数据
    func requestCategoryList(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("goods/goodsCategoryList",parameters: nil,method :.get,  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].array else { return }
                for item in data{
                    guard let itemInfo = item.dictionaryObject else { return }
                    let model = JSLGoodsCategoryModel.init(dict: itemInfo)
                    
                    weakSelf?.catrgoryList.append(model)
                    weakSelf?.catrgoryNameList.append(model.name!)
                }
                weakSelf?.reloadData()
                
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
            
        })
    }
    
    /// 重新加载
    func reloadData() {
        if catrgoryNameList.count > 0 {
            //一定要统一segmentedDataSource、segmentedView、listContainerView的defaultSelectedIndex
            segmentedViewDataSource.titles = catrgoryNameList
            //reloadData(selectedIndex:)一定要调用
            segmentedViewDataSource.reloadData(selectedIndex: 0)
            
            segmentedView.defaultSelectedIndex = 0
            segmentedView.reloadData()
            
            pagingView.defaultSelectedIndex = 0
            pagingView.reloadData()
        }
    }
    ///获取热门搜索数据
    func requestHotSearchList(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        
        GYZNetWork.requestNetwork("index/getGoodsWords",parameters: nil,method :.get,  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].array else { return }
                for item in data{
                    
                    weakSelf?.searchHotList.append(item.stringValue)
                }
                
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
            
        })
    }
    /// 搜索
    @objc func onClickedSearch(){
        let searchVC: PYSearchViewController = PYSearchViewController.init(hotSearches: searchHotList, searchBarPlaceholder: "搜索感兴趣的内容") { (searchViewController, searchBar, searchText) in
            
            let searchVC = JSLSearchShopVC()
            searchVC.searchContent = searchText!
            searchViewController?.navigationController?.pushViewController(searchVC, animated: true)
        }
        
        let searchNav = GYZBaseNavigationVC(rootViewController:searchVC)
        //
        searchVC.cancelButton.setTitleColor(kHeightGaryFontColor, for: .normal)
        
        /// 搜索框背景色
        if #available(iOS 13.0, *){
            searchVC.searchBar.searchTextField.backgroundColor = kGrayBackGroundColor
        }else{
            searchVC.searchBarBackgroundColor = kGrayBackGroundColor
        }
        //显示输入光标
        searchVC.searchBar.tintColor = kHeightGaryFontColor
        searchVC.searchHistoriesCachePath = searchShopHistoryPath
        self.present(searchNav, animated: true, completion: nil)
    }
}
extension JSLShopVC: JXPagingViewDelegate {
    
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
        return catrgoryNameList.count
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        let vc = JSLShopListVC()
        vc.categoryId = catrgoryList[index].id!
        vc.naviController = self.navigationController
        return vc
    }
    
    func mainTableViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension JSLShopVC: JXSegmentedViewDelegate {
    //    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
    //
    //        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    //    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        self.pagingView.listContainerView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
    }
}

