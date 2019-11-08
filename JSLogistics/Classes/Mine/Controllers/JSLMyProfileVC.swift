//
//  JSLMyProfileVC.swift
//  JSLogistics
//  我的资料
//  Created by gouyz on 2019/11/4.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import SKPhotoBrowser
import MBProgressHUD

private let myProfileHeader = "myProfileHeader"
private let myProfileImgCell = "myProfileImgCell"

class JSLMyProfileVC: GYZBaseVC {
    
    var userInfoModel: JSLUserInfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的资料"
        self.view.backgroundColor = kWhiteColor
        let rightBtn = UIButton(type: .custom)
        rightBtn.setTitle("编辑", for: .normal)
        rightBtn.titleLabel?.font = k15Font
        rightBtn.setTitleColor(kGreenFontColor, for: .normal)
        rightBtn.frame = CGRect.init(x: 0, y: 0, width: kTitleHeight, height: kTitleHeight)
        rightBtn.addTarget(self, action: #selector(onClickRightBtn), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        requestMineInfo()
    }
    
    lazy var collectionView: UICollectionView = {
        
        let itemWidth = floor((kScreenWidth - kMargin * 4)/3)
        let layout = UICollectionViewFlowLayout()
        //设置cell的大小
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        layout.sectionInset = UIEdgeInsets.init(top: kMargin, left: kMargin, bottom: kMargin, right: kMargin)
        layout.headerReferenceSize = CGSize.init(width: kScreenWidth, height: 240)
        
        let collView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collView.dataSource = self
        collView.delegate = self
        collView.alwaysBounceHorizontal = false
        collView.backgroundColor = kWhiteColor
        
        collView.register(JSLMyProfilePhotoCell.classForCoder(), forCellWithReuseIdentifier: myProfileImgCell)
        collView.register(JSLMyProfileHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: myProfileHeader)
        
        
        return collView
    }()
    //我的 资料
    func requestMineInfo(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("user/userInfo", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? ""],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
        
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].dictionaryObject else { return }
                weakSelf?.userInfoModel = JSLUserInfoModel.init(dict: data)
                weakSelf?.collectionView.reloadData()
            
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    /// 编辑
    @objc func onClickRightBtn(){
        let vc = JSLEditMyProfileVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension JSLMyProfileVC: UICollectionViewDataSource,UICollectionViewDelegate{
    
    // MARK: UICollectionViewDataSource 代理方法
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if userInfoModel != nil {
            return (userInfoModel?.imgList.count)!
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myProfileImgCell, for: indexPath) as! JSLMyProfilePhotoCell
        
        cell.iconView.kf.setImage(with: URL.init(string: (userInfoModel?.imgList[indexPath.row])!))
        cell.deleteImgView.isHidden = true
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview: UICollectionReusableView!
        
        if kind == UICollectionView.elementKindSectionHeader{
            
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: myProfileHeader, for: indexPath) as! JSLMyProfileHeaderView
            
            (reusableview as! JSLMyProfileHeaderView).dataModel = userInfoModel
        }
        
        return reusableview
    }
    // MARK: UICollectionViewDelegate的代理方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
