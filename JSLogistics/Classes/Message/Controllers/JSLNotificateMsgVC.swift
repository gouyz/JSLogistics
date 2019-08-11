//
//  JSLNotificateMsgVC.swift
//  JSLogistics
//  通知消息
//  Created by gouyz on 2019/8/11.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

private let notificateMsgCell = "notificateMsgCell"

class JSLNotificateMsgVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "通知消息"
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
        
        table.register(JSLFenSiMsgListCell.classForCoder(), forCellReuseIdentifier: notificateMsgCell)
        
        return table
    }()
}
extension JSLNotificateMsgVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: notificateMsgCell) as! JSLFenSiMsgListCell
        
        cell.operatorBtn.snp.updateConstraints { (make) in
            make.size.equalTo(CGSize.zero)
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
