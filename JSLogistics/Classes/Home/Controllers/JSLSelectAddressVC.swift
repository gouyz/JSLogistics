//
//  JSLSelectAddressVC.swift
//  JSLogistics
//  选择目的地
//  Created by gouyz on 2019/11/25.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

private let selectAddressCell = "selectAddressCell"

class JSLSelectAddressVC: GYZBaseVC {
    
    /// 选择结果回调
    var resultBlock:((_ address: AMapPOI?) -> Void)?
    
    /// 搜索 内容
    var searchContent: String = ""
    /// poi搜索
    let searchAPI: AMapSearchAPI = AMapSearchAPI()
    var dataList:[AMapPOI] = [AMapPOI]()
    var currCityModel: FSCityListModel?
    /// 当前选中的POI
    var selectPoi:AMapPOI?
    
    /// 高德地图定位
    let locationManager: AMapLocationManager = AMapLocationManager()
    
    var cityName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBtn = UIButton(type: .custom)
        rightBtn.setTitle("取消", for: .normal)
        rightBtn.titleLabel?.font = k15Font
        rightBtn.setTitleColor(kHeightGaryFontColor, for: .normal)
        rightBtn.frame = CGRect.init(x: 0, y: 0, width: kTitleHeight, height: kTitleHeight)
        rightBtn.addTarget(self, action: #selector(onClickRightBtn), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        
        navigationItem.titleView = searchBar
        /// 解决iOS11中UISearchBar高度变大
        if #available(iOS 11.0, *) {
            searchBar.heightAnchor.constraint(equalToConstant: kTitleHeight).isActive = true
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        /// 获取当前选择城市
        if let currModel =  userDefaults.data(forKey: CURRCITYINFO){
            currCityModel = NSKeyedUnarchiver.unarchiveObject(with: currModel) as? FSCityListModel
            cityName = (currCityModel?.name)!
        }
        initLocation()
        searchAPI.delegate = self
        
    }
    /// 搜索框
    lazy var searchBar : UISearchBar = {
        let search = UISearchBar()
        
        search.placeholder = "您要去哪儿"
        search.delegate = self
        //显示输入光标
        search.tintColor = kHeightGaryFontColor
        /// 搜索框背景色
        if #available(iOS 13.0, *){
            search.searchTextField.backgroundColor = kGrayBackGroundColor
        }else{
            if let textfiled = search.subviews.first?.subviews.last as? UITextField {
                textfiled.backgroundColor = kGrayBackGroundColor
            }
        }
        //弹出键盘
        //        search.becomeFirstResponder()
        
        return search
    }()
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = kWhiteColor
        
        table.register(JSLSelectAddressCell.classForCoder(), forCellReuseIdentifier: selectAddressCell)
        
        return table
    }()
    
    /// 取消
    @objc func onClickRightBtn(){
        searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    /// 初始化高德地图定位
    func initLocation(){
        locationManager.delegate = self
        /// 设置定位最小更新距离
        locationManager.distanceFilter = 200
        locationManager.locatingWithReGeocode = true
        locationManager.startUpdatingLocation()
    }
    
    /// 关键字检索
    func searchPOI(keyword: String?) {
        
        if keyword == nil || keyword! == "" {
            return
        }
        
        let request = AMapPOIKeywordsSearchRequest()
        request.keywords = keyword
        request.requireExtension = true
        request.offset = 50
        request.city = cityName
        
        searchAPI.aMapPOIKeywordsSearch(request)
    }
    /// 周边检索
    func searchAroundPOI(point: AMapGeoPoint) {
        
        let request = AMapPOIAroundSearchRequest()
        
        request.location = point
        request.keywords = ""
        request.requireExtension = true
        request.offset = 50
        
        searchAPI.aMapPOIAroundSearch(request)
    }
}
extension JSLSelectAddressVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: selectAddressCell) as! JSLSelectAddressCell
        
        let model = dataList[indexPath.row]
        cell.nameLab.text = model.name
        cell.desLab.text = model.address
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if resultBlock != nil {
            resultBlock!(dataList[indexPath.row])
        }
        self.dismiss(animated: true, completion: nil)
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}

extension JSLSelectAddressVC: UISearchBarDelegate {
    ///mark - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        self.searchContent = searchBar.text ?? ""
        
        searchPOI(keyword: searchContent)
    }
    
}
extension JSLSelectAddressVC : AMapSearchDelegate{
    //MARK: - AMapSearchDelegate
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        NSLog("Error:\(error)")
    }
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        dataList = response.pois
        tableView.reloadData()
    }
}
extension JSLSelectAddressVC:AMapLocationManagerDelegate{
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode?) {
        
        searchAroundPOI(point: AMapGeoPoint.location(withLatitude: CGFloat(location.coordinate.latitude), longitude: CGFloat(location.coordinate.longitude)))
        NSLog("location:{lat:\(location.coordinate.latitude); lon:\(location.coordinate.longitude); accuracy:\(location.horizontalAccuracy);};");
        
        if let reGeocode = reGeocode {
            if reGeocode.city != nil{
                cityName = reGeocode.city
            }
            locationManager.stopUpdatingLocation()
            NSLog("reGeocode:%@", reGeocode)
            
        }
    }
    func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
        
    }
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        GYZLog(error)
    }
}
