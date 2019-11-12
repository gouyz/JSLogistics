//
//  JSLFenSiMsgListVC.swift
//  JSLogistics
//  粉丝列表
//  Created by gouyz on 2019/8/11.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD

private let fenSiMsgListCell = "fenSiMsgListCell"

class JSLFenSiMsgListVC: GYZBaseVC {
    var currPage : Int = 0
    /// 最后一页
    var lastPage: Int = 1
    var dataList: [JSLNotificationModel] = [JSLNotificationModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "粉丝列表"
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
        
        table.register(JSLFenSiMsgListCell.classForCoder(), forCellReuseIdentifier: fenSiMsgListCell)
        
        return table
    }()
}
extension JSLFenSiMsgListVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: fenSiMsgListCell) as! JSLFenSiMsgListCell
        
        if indexPath.row == 2 {
            cell.operatorBtn.isUserInteractionEnabled = true
            cell.operatorBtn.isSelected = true
            cell.operatorBtn.backgroundColor = kGreenFontColor
        }else{
            cell.operatorBtn.isUserInteractionEnabled = false
            cell.operatorBtn.isSelected = false
            cell.operatorBtn.backgroundColor = kWhiteColor
        }
        
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
