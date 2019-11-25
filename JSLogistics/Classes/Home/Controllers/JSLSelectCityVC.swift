//
//  JSLSelectCityVC.swift
//  JSLogistics
//  选择城市
//  Created by gouyz on 2019/11/25.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD

private let selectHotCityCell = "selectHotCityCell"
private let selectAllCityCell = "selectAllCityCell"
private let selectCityHeader = "selectCityHeader"

class JSLSelectCityVC: GYZBaseVC {
    
    var cityList:[JSLCityModel] = [JSLCityModel]()
    var hotCityList:[JSLCityModel] = [JSLCityModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "选择城市"
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        requestCityList()
    }
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets.init(top: kMargin, left: kMargin, bottom: kMargin, right: kMargin)
        layout.headerReferenceSize = CGSize.init(width: kScreenWidth, height: kTitleHeight)
        
        let collView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collView.dataSource = self
        collView.delegate = self
        collView.alwaysBounceHorizontal = false
        collView.backgroundColor = kWhiteColor
        
        collView.register(JSLHotCityCell.classForCoder(), forCellWithReuseIdentifier: selectHotCityCell)
        collView.register(JSLAllCityCell.classForCoder(), forCellWithReuseIdentifier: selectAllCityCell)
        collView.register(JSLSelectCityHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: selectCityHeader)
        
        
        return collView
    }()
    //城市列表
    func requestCityList(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("city/index", parameters: nil,  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"]["hot_city"].array else { return }
                for item in data{
                    guard let itemInfo = item.dictionaryObject else { return }
                    let model = JSLCityModel.init(dict: itemInfo)
                    
                    weakSelf?.hotCityList.append(model)
                }
                guard let cityData = response["result"]["all_city"].array else { return }
                for item in cityData{
                    guard let itemInfo = item.dictionaryObject else { return }
                    let model = JSLCityModel.init(dict: itemInfo)
                    
                    weakSelf?.cityList.append(model)
                }
                weakSelf?.collectionView.reloadData()
                
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
}
extension JSLSelectCityVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource 代理方法
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return hotCityList.count
        }
        return cityList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectHotCityCell, for: indexPath) as! JSLHotCityCell
            
            cell.imgView.kf.setImage(with: URL.init(string: hotCityList[indexPath.row].img!))
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectAllCityCell, for: indexPath) as! JSLAllCityCell
            
            cell.nameLab.text = cityList[indexPath.row].name
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview: UICollectionReusableView!
        
        if kind == UICollectionView.elementKindSectionHeader{
            
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: selectCityHeader, for: indexPath) as! JSLSelectCityHeaderView
            
            if indexPath.section == 0 {
                (reusableview as! JSLSelectCityHeaderView).nameLab.text = "热门城市"
            }else{
                (reusableview as! JSLSelectCityHeaderView).nameLab.text = "全部城市"
            }
        }
        
        return reusableview
    }
    // MARK: UICollectionViewDelegate的代理方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize.init(width: (kScreenWidth - kMargin * 3)/2, height: (kScreenWidth - kMargin * 3)/4)
        }
        
        return CGSize.init(width: floor((kScreenWidth - kMargin * 4)/3), height: 30)
    }
}
