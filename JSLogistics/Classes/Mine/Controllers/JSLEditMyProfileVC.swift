//
//  JSLEditMyProfileVC.swift
//  JSLogistics
//  编辑资料
//  Created by gouyz on 2019/11/4.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD

private let editMyProfileCell = "editMyProfileCell"
private let editMyProfilePhotoCell = "editMyProfilePhotoCell"
private let editMyProfilePhotoHeader = "editMyProfilePhotoHeader"

class JSLEditMyProfileVC: GYZBaseVC {
    
    let titleArr: [String] = ["头像","昵称","电话","生日","性别","个人签名","邮箱","所在地"]
    
    var selectSexIndex: Int = 0
    let sexNameArr:[String] = ["保密","男","女"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "编辑资料"
        let rightBtn = UIButton(type: .custom)
        rightBtn.setTitle("保存", for: .normal)
        rightBtn.titleLabel?.font = k15Font
        rightBtn.setTitleColor(kGreenFontColor, for: .normal)
        rightBtn.frame = CGRect.init(x: 0, y: 0, width: kTitleHeight, height: kTitleHeight)
        rightBtn.addTarget(self, action: #selector(onClickRightBtn), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        
        self.view.backgroundColor = kWhiteColor
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorColor = kGrayLineColor
        table.backgroundColor = kBackgroundColor
        
        
        table.register(GYZMyProfileCell.classForCoder(), forCellReuseIdentifier: editMyProfileCell)
        table.register(JSLUploadPhotoCell.classForCoder(), forCellReuseIdentifier: editMyProfilePhotoCell)
        table.register(LHSGeneralHeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: editMyProfilePhotoHeader)
        
        return table
    }()
    @objc func onClickRightBtn(){
        
    }
    
    /// 选择性别
    func showSelectSex(){
        UsefulPickerView.showSingleColPicker("选择性别", data: sexNameArr, defaultSelectedIndex: selectSexIndex) {[unowned self] (index, value) in
            
            self.selectSexIndex = index
            self.tableView.reloadData()
        }
    }
    /// 选择生日
    func showSelectBirthday(){
        UsefulPickerView.showDatePicker("选择生日") { [unowned self](date) in
            
            //                self?.dateView.textFiled.text = date.dateToStringWithFormat(format: "yyyy-MM-dd")
        }
    }
    /// 选择所在城市
    func showSelectCity(){
        UsefulPickerView.showCitiesPicker("选择所在城市", defaultSelectedValues: ["四川", "成都", "郫县"]) {[unowned self] (selectedIndexs, selectedValues) in
            // 处理数据
            let combinedString = selectedValues.reduce("", { (result, value) -> String in
                result + " " + value
            })
            GYZLog(combinedString)
        }
    }
}

extension JSLEditMyProfileVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return titleArr.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: editMyProfileCell) as! GYZMyProfileCell
            
            cell.userImgView.isHidden = true
            cell.nameLab.text = titleArr[indexPath.row]
            
            if indexPath.row == 0 {
                cell.userImgView.isHidden = false
            }
            
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: editMyProfilePhotoCell) as! JSLUploadPhotoCell
            
            
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: editMyProfilePhotoHeader) as! LHSGeneralHeaderView
            
            headerView.nameLab.text = "精选照片"
            return headerView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {// 选择性别
            showSelectSex()
        }else if indexPath.row == 3 {// 选择生日
            showSelectBirthday()
        }else if indexPath.row == 7 {// 选择城市
            showSelectCity()
        }
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 64
            }
            return 50
        }
        return floor((kScreenWidth - kMargin * 5)/4) + 20
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return kTitleHeight
        }
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return kMargin
        }
        return 0.00001
    }
    
}
