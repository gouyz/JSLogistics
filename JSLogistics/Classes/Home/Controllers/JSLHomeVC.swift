//
//  JSLHomeVC.swift
//  JSLogistics
//  即时美食
//  Created by gouyz on 2019/8/7.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import JXSegmentedView
import JXPagingView
import MBProgressHUD
import PYSearch

private let searchHomeHistoryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "PYSearchhistoriesHome.plist" // the path of search record cached

class JSLHomeVC: JSLCommonNavVC {
    
    var segmentedViewDataSource: JXSegmentedTitleDataSource!
    let JXTableHeaderViewHeight: Int = Int(kScreenWidth * 0.35 + kTitleHeight)
    //    let titles = ["TOP推荐", "网红", "中餐", "西餐", "下午茶", "火锅", "龙虾", "糕点", "麻辣烫"]
    /// 分类
    var catrgoryList: [JSLPublishCategoryModel] = [JSLPublishCategoryModel]()
    var catrgoryNameList: [String] = [String]()
    /// 轮播图
    var adsList:[JSLHomeAdsModel] = [JSLHomeAdsModel]()
    var adsImgUrlList: [String] = [String]()
    
    /// 高德地图定位
    let locationManager: AMapLocationManager = AMapLocationManager()
    var searchHotList: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocation()
        self.view.addSubview(pagingView)
        pagingView.snp.makeConstraints { (make) in
            //            make.top.equalTo(kTitleAndStateHeight)
            make.top.left.right.bottom.equalTo(self.view)
        }
        
        segmentedView.contentScrollView = pagingView.listContainerView.collectionView
        
        headerView.isUserInteractionEnabled = true
        headerView.searchView.searchBtn.addTarget(self, action: #selector(onClickedSearch), for: .touchUpInside)
        
        requestAdsList()
        requestCategoryList()
        requestHotSearchList()
    }
    
    /// 初始化高德地图定位
    func initLocation(){
        locationManager.delegate = self
        /// 设置定位最小更新距离
        locationManager.distanceFilter = 200
        locationManager.locatingWithReGeocode = true
        locationManager.startUpdatingLocation()
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
    lazy var headerView: JSLHomeHeaderView = JSLHomeHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: CGFloat(JXTableHeaderViewHeight)))
    
    ///获取轮播广告数据
    func requestAdsList(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("index/ad",parameters: nil,method :.get,  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].array else { return }
                for item in data{
                    guard let itemInfo = item.dictionaryObject else { return }
                    let model = JSLHomeAdsModel.init(dict: itemInfo)
                    
                    weakSelf?.adsList.append(model)
                    weakSelf?.adsImgUrlList.append(model.ad_code!)
                }
                weakSelf?.headerView.adsImgView.setUrlsGroup((weakSelf?.adsImgUrlList)!)
                
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
            
        })
    }
    ///获取发布分类数据
    func requestCategoryList(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("publish/getPublishType",parameters: nil,method :.get,  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].array else { return }
                for item in data{
                    guard let itemInfo = item.dictionaryObject else { return }
                    let model = JSLPublishCategoryModel.init(dict: itemInfo)
                    
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
        
        GYZNetWork.requestNetwork("index/getHotWords",parameters: nil,method :.get,  success: { (response) in
            
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
        let searchVC: PYSearchViewController = PYSearchViewController.init(hotSearches: searchHotList, searchBarPlaceholder: "搜索你喜爱的美食") { (searchViewController, searchBar, searchText) in
            
            let searchVC = JSLSearchHomeVC()
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
        searchVC.searchHistoriesCachePath = searchHomeHistoryPath
        self.present(searchNav, animated: true, completion: nil)
    }
}
extension JSLHomeVC: JXPagingViewDelegate {
    
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
        let vc = JSLHomeListVC()
        vc.categoryId = catrgoryList[index].type_id!
        vc.naviController = self.navigationController
        return vc
    }
    
    func mainTableViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension JSLHomeVC: JXSegmentedViewDelegate {
    //    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
    //
    //        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    //    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        self.pagingView.listContainerView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
    }
}
extension JSLHomeVC:AMapLocationManagerDelegate{
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode?) {
        NSLog("location:{lat:\(location.coordinate.latitude); lon:\(location.coordinate.longitude); accuracy:\(location.horizontalAccuracy);};");
        // 存储定位经纬度
        userDefaults.set(location.coordinate.latitude, forKey: CURRlatitude)
        userDefaults.set(location.coordinate.longitude, forKey: CURRlongitude)
        if let reGeocode = reGeocode {
            locationManager.stopUpdatingLocation()
            NSLog("reGeocode:%@", reGeocode)
            if reGeocode.city != nil{
//                findLocationCity(cityName: reGeocode.city)
            }
        }
    }
    func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
        
    }
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        GYZLog(error)
    }
    
}
