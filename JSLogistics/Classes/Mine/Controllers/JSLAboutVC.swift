//
//  JSLAboutVC.swift
//  JSLogistics
//  关于我们
//  Created by gouyz on 2019/10/16.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

private let aboutCell = "aboutCell"
private let aboutHeader = "aboutHeader"

class JSLAboutVC: GYZBaseVC {
    
    let titleArray = ["二维码", "检测更新", "用户协议", "服务热线"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "关于我们"
        
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
        table.backgroundColor = kWhiteColor
        
        table.register(GYZMyProfileCell.self, forCellReuseIdentifier: aboutCell)
        table.register(JSLAboutHeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: aboutHeader)
        
        return table
    }()
    
}

extension JSLAboutVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: aboutCell) as! GYZMyProfileCell
        
        cell.desLab.textColor = kGaryFontColor
        cell.userImgView.isHidden = true
        cell.desLab.isHidden = true
        cell.desLab.textColor = kGaryFontColor
        cell.rightIconView.isHidden = false
        cell.nameLab.text = titleArray[indexPath.row]
        
        if indexPath.row == 0{
            cell.userImgView.isHidden = false
            cell.userImgView.cornerRadius = 1
            cell.rightIconView.isHidden = true
            cell.userImgView.image = UIImage.init(named: "icon_qrcode_default")
        }else if indexPath.row == 3{
            cell.desLab.isHidden = false
            cell.desLab.text = "400-2587-1256"
            cell.desLab.textColor = kGreenFontColor
        }
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: aboutHeader) as! JSLAboutHeaderView
        
        
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}


