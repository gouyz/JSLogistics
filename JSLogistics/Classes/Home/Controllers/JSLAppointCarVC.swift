//
//  JSLAppointCarVC.swift
//  JSLogistics
//  出行预约
//  Created by gouyz on 2019/11/25.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD

class JSLAppointCarVC: GYZBaseVC {
    /// 第一次定位
    var userFirstLoca: Bool = false
    /// poi搜索
    let searchAPI: AMapSearchAPI = AMapSearchAPI()
    /// 出发地 经度
    var addressLongitude : CGFloat = 0
    /// 出发地 纬度
    var addressLatitude : CGFloat = 0
    /// 目的地 经度
    var toAddressLongitude : CGFloat = 0
    /// 目的地 纬度
    var toAddressLatitude : CGFloat = 0
    /// 选择预约日期
    var selectDate:String = ""
    /// 车费
    var money:String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "出行"
        
        searchAPI.delegate = self
        view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        view.addSubview(bottomView)
        bottomView.addSubview(appointDateView)
        bottomView.addSubview(rightIconView)
        bottomView.addSubview(lineView)
        bottomView.addSubview(addressTagView)
        
        bottomView.addSubview(addressView)
        addressView.addSubview(addressLab)
        addressView.addSubview(addressDetailLab)
        
        bottomView.addSubview(lineView1)
        bottomView.addSubview(toAddressTagView)
        bottomView.addSubview(toAddressView)
        toAddressView.addSubview(toAddressLab)
        toAddressView.addSubview(toAddressDetailLab)
        
        bottomView.addSubview(payBtn)
        
        bottomView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.bottom.equalTo(-20)
            make.height.equalTo(240)
        }
        appointDateView.snp.makeConstraints { (make) in
            make.top.equalTo(bottomView)
            make.left.equalTo(kMargin)
            make.right.equalTo(rightIconView.snp.left).offset(-5)
            make.height.equalTo(58)
        }
        rightIconView.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.centerY.equalTo(appointDateView)
            make.size.equalTo(rightArrowSize)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(bottomView)
            make.height.equalTo(klineWidth)
            make.top.equalTo(appointDateView.snp.bottom)
        }
        addressView.snp.makeConstraints { (make) in
            make.left.equalTo(addressTagView.snp.right).offset(kMargin)
            make.top.equalTo(lineView.snp.bottom)
            make.right.equalTo(-kMargin)
            make.height.equalTo(60)
        }
        addressTagView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.centerY.equalTo(addressLab)
            make.size.equalTo(CGSize.init(width: 8, height: 8))
        }
        addressLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(addressView)
            make.top.equalTo(kMargin)
            make.height.equalTo(20)
        }
        addressDetailLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(addressView)
            make.top.equalTo(addressLab.snp.bottom)
            make.bottom.equalTo(-kMargin)
        }
        lineView1.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(addressView.snp.bottom)
            make.height.equalTo(klineWidth)
        }
        
        toAddressView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom)
            make.left.equalTo(toAddressTagView.snp.right).offset(kMargin)
            make.right.equalTo(kMargin)
            make.height.equalTo(addressView)
        }
        toAddressTagView.snp.makeConstraints { (make) in
            make.left.size.equalTo(addressTagView)
            make.centerY.equalTo(toAddressLab)
        }
        toAddressLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(toAddressView)
            make.top.equalTo(kMargin)
            make.height.equalTo(20)
        }
        toAddressDetailLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(toAddressView)
            make.top.equalTo(toAddressLab.snp.bottom)
            make.bottom.equalTo(-kMargin)
        }
        
        payBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(bottomView)
            make.size.equalTo(CGSize.init(width: 100, height: 34))
            make.bottom.equalTo(-kMargin)
        }
    }
    lazy var mapView: MAMapView = {
        let map = MAMapView()
        map.delegate = self
        // 开启定位
        map.showsUserLocation = true
        map.userTrackingMode = MAUserTrackingMode.follow
        map.zoomLevel = 17
        
        return map
    }()
    
    lazy var bottomView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = kWhiteColor
        bgView.cornerRadius = kCornerRadius
        bgView.isUserInteractionEnabled = true
        
        return bgView
    }()
    /// 预约时间
    lazy var appointDateView: GYZLabAndLabView = {
        let dateView = GYZLabAndLabView.init()
        dateView.desLab.text = "预约时间"
        dateView.contentLab.text = "请选择预约时间"
        dateView.contentLab.textAlignment = .right
        
        dateView.addOnClickListener(target: self, action: #selector(onClickedSelectDate))
        
        return dateView
    }()
    /// 右侧箭头图标
    lazy var rightIconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_right_arrow"))
    
    /// 分割线
    var lineView : UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        return line
    }()
    
    ///
    lazy var addressTagView: UIView = {
        let view = UIView()
        view.backgroundColor = kOrangeFontColor
        view.cornerRadius = 4
        
        return view
    }()
    
    lazy var addressView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = kWhiteColor
        
        return bgView
    }()
    /// 出发地址
    lazy var addressLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k15Font
        lab.text = "从这里出发"
        
        return lab
    }()
    /// 出发详细地址
    lazy var addressDetailLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kOrangeFontColor
        lab.font = k13Font
        
        return lab
    }()
    /// 分割线
    var lineView1 : UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        return line
    }()
    ///
    lazy var toAddressTagView: UIView = {
        let view = UIView()
        view.backgroundColor = kGreenFontColor
        view.cornerRadius = 4
        
        return view
    }()
    lazy var toAddressView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = kWhiteColor
        
        bgView.addOnClickListener(target: self, action: #selector(onClickedSelectedToAddress))
        
        return bgView
    }()
    /// 目的地址
    lazy var toAddressLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k15Font
        lab.text = "您要去哪儿"
        
        return lab
    }()
    /// 目的详细地址
    lazy var toAddressDetailLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGreenFontColor
        lab.font = k13Font
        
        return lab
    }()
    /// 计算车费
    lazy var payBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.setTitle("计算车费", for: .normal)
        btn.backgroundColor = kGreenFontColor
        btn.cornerRadius = 17
        
        btn.addTarget(self, action: #selector(onClickedPay), for: .touchUpInside)
        
        return btn
    }()
    // 选择目的地
    @objc func onClickedSelectedToAddress(){
        let vc = JSLSelectAddressVC()
        vc.resultBlock = {[unowned self] (address) in
//            self.currAddress = address
            if  address != nil {
                self.toAddressLab.text = address?.name
                self.toAddressDetailLab.text = address?.address
                
                self.toAddressLatitude = (address?.location.latitude)!
                self.toAddressLongitude = (address?.location.longitude)!
            }
        }
        let seeNav = GYZBaseNavigationVC(rootViewController:vc)
        self.present(seeNav, animated: true, completion: nil)
    }
    /// 选择预约时间
    @objc func onClickedSelectDate(){
        var dateStyle = DatePickerSetting()
        dateStyle.dateMode = .dateAndTime
        UsefulPickerView.showDatePicker("选择预约时间", datePickerSetting: dateStyle) {[unowned self] (date) in
            
            self.selectDate = date.dateToStringWithFormat(format: "yyyy-MM-dd HH:mm")
            self.appointDateView.contentLab.text = self.selectDate
        }
    }
    
    /// 计算车费
    @objc func onClickedPay(){
        if selectDate.isEmpty {
            MBProgressHUD.showAutoDismissHUD(message: "请选择预约时间")
            return
        }
        if addressLongitude == 0 || addressLatitude == 0 {
            MBProgressHUD.showAutoDismissHUD(message: "请选择出发地")
            return
        }
        if toAddressLongitude == 0 || toAddressLatitude == 0 {
            MBProgressHUD.showAutoDismissHUD(message: "请选择目的地")
            return
        }
        
        requestMoney()
    }
    //计算车费
    func requestMoney(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("appointment/money", parameters: ["longitude1":addressLongitude,"latitude1":addressLatitude,"longitude2":toAddressLongitude,"latitude2":toAddressLatitude],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
        
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                weakSelf?.money = response["result"].stringValue
                weakSelf?.showAlertView()
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    
    func showAlertView(){
        let alertView = JSLAppointCarOrderAlertView()
        alertView.moneyLab.text = "共计\(money)元"
        alertView.show()
        alertView.action = {[unowned self] (alert,index) in
            if index == 2 {// 确定
                self.requestSubmitOrder()
            }
        }
    }
    
    //下单
    func requestSubmitOrder(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("appointment/appoint", parameters: ["longitude1":addressLongitude,"latitude1":addressLatitude,"longitude2":toAddressLongitude,"latitude2":toAddressLatitude,"time":selectDate,"departure":addressDetailLab.text!,"destination":toAddressDetailLab.text!,"user_id":userDefaults.string(forKey: "userId") ?? ""],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
        
            MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    
}
extension JSLAppointCarVC: MAMapViewDelegate{
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKind(of: MAPointAnnotation.self) {
            let pointReuseIndetifier = "appointCarPointReuseIndetifier"
            var annotationView: MAPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier) as! MAPinAnnotationView?
            
            if annotationView == nil {
                annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }
            
            annotationView!.canShowCallout = true
            annotationView!.animatesDrop = true
            annotationView!.isDraggable = true
            
            return annotationView!
        }
        
        return nil
    }
    /* 位置或者设备方向更新后，会调用此函数 */
    // 为了得到用户初始的位置，创建Annotation
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        
        // 目的是只用第一次定位的数据，即用户的初始位置
        if !self.userFirstLoca {
            self.userFirstLoca = true
            
            let anno = MAPointAnnotation()
            anno.title = "从这里上车"
            anno.coordinate = userLocation.location.coordinate
            //固定Annotation并放置地图中心点
            anno.isLockedToScreen = true
            anno.lockedScreenPoint = self.mapView.center
            
            self.mapView.addAnnotation(anno)
            self.mapView.selectAnnotation(anno, animated: true)
        }
    }
    /* 地图移动结束后调用此接口 */
    func mapView(_ mapView: MAMapView!, mapDidMoveByUser wasUserAction: Bool) {
        
        // 将指定view坐标系的坐标转换为经纬度
        let moveCoor: CLLocationCoordinate2D = mapView.convert(mapView.center, toCoordinateFrom: mapView)
        // 通过坐标点得到经纬度，从而进行反地理编码
        let rego: AMapReGeocodeSearchRequest = AMapReGeocodeSearchRequest.init()
        // 是否返回扩展信(因为我们需要得到附近地理位置信息，所以设为YES)
        rego.requireExtension = true
        rego.location  = AMapGeoPoint.location(withLatitude: CGFloat(moveCoor.latitude), longitude: CGFloat(moveCoor.longitude))
        self.searchAPI.aMapReGoecodeSearch(rego)
    }
    
}
extension JSLAppointCarVC : AMapSearchDelegate{
    //MARK: - AMapSearchDelegate
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        NSLog("Error:\(error)")
    }
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        if response.regeocode.pois.count > 0 {
            GYZLog("address:\((response.regeocode.pois[0]))")
            let poiModel = response.regeocode.pois[0]
            addressLatitude = poiModel.location.latitude
            addressLongitude = poiModel.location.longitude
            addressLab.text = poiModel.name
            addressDetailLab.text = poiModel.address
        }
    }
}
