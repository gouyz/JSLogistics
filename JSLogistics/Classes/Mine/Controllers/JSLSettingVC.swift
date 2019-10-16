//
//  JSLSettingVC.swift
//  JSLogistics
//  设置
//  Created by gouyz on 2019/10/16.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

private let settingCell = "settingCell"
private let settingLoginOutFooter = "settingLoginOutFooter"

class JSLSettingVC: GYZBaseVC {
    
    let titleArr:[String] = ["关于我们","清楚缓存"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "设置"
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
        
        table.register(GYZLabArrowCell.classForCoder(), forCellReuseIdentifier: settingCell)
        table.register(JSLLoginOutFooterView.classForCoder(), forHeaderFooterViewReuseIdentifier: settingLoginOutFooter)
        
        return table
    }()
}
extension JSLSettingVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: settingCell) as! GYZLabArrowCell
        
        cell.nameLab.text = titleArr[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: settingLoginOutFooter) as! JSLLoginOutFooterView
        
        
        return headerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 170
    }
}

