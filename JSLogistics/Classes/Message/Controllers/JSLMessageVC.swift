//
//  JSLMessageVC.swift
//  JSLogistics
//  消息
//  Created by gouyz on 2019/8/7.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

private let messageCell = "messageCell"
private let messageHeader = "messageHeader"

class JSLMessageVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "消息"
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
        
        table.register(JSLMessageCell.classForCoder(), forCellReuseIdentifier: messageCell)
        table.register(JSLMessageHeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: messageHeader)
        
        return table
    }()
}
extension JSLMessageVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: messageCell) as! JSLMessageCell
        
        if indexPath.row == 0 {// 通知消息
            cell.tagImgView.image = UIImage.init(named: "icon_msg_notification")
            cell.dateLab.isHidden = true
            cell.nameLab.text = "通知消息"
            cell.desLab.text = "您发布的文章未通过审核"
        }else{
            cell.tagImgView.image = UIImage.init(named: "icon_msg_care")
            cell.dateLab.isHidden = false
            cell.nameLab.text = "关注消息"
            cell.desLab.text = "XXX 发表了新的美食笔记"
        }
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: messageHeader) as! JSLMessageHeaderView
        
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
