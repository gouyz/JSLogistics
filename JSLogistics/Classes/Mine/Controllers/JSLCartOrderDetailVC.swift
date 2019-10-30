//
//  JSLCartOrderDetailVC.swift
//  JSLogistics
//  购物订单、即时出行详情
//  Created by gouyz on 2019/10/29.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD

private let cartOrderDetailCell = "cartOrderDetailCell"
private let cartOrderDetailTripCell = "cartOrderDetailTripCell"
private let cartOrderDetailHeaderCell = "cartOrderDetailHeaderCell"
private let cartOrderDetailInfoCell = "cartOrderDetailInfoCell"

class JSLCartOrderDetailVC: GYZBaseVC {
    
    /// 1购物订单、2即时出行
    var orderType: String = "1"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "订单详情"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = kBackgroundColor
        
        
        table.register(JSLCartOrderListCell.classForCoder(), forCellReuseIdentifier: cartOrderDetailCell)
        table.register(JSLRunOrderListCell.classForCoder(), forCellReuseIdentifier: cartOrderDetailTripCell)
        table.register(JSLCartOrderDetailHeaderCell.classForCoder(), forCellReuseIdentifier: cartOrderDetailHeaderCell)
        table.register(JSLCartOrderInfoCell.classForCoder(), forCellReuseIdentifier: cartOrderDetailInfoCell)
        
        return table
    }()

}
extension JSLCartOrderDetailVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cartOrderDetailHeaderCell) as! JSLCartOrderDetailHeaderCell
            
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 1{
            
            if orderType == "1" {
                let cell = tableView.dequeueReusableCell(withIdentifier: cartOrderDetailCell) as! JSLCartOrderListCell
                
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: cartOrderDetailTripCell) as! JSLRunOrderListCell
                
                cell.selectionStyle = .none
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cartOrderDetailInfoCell) as! JSLCartOrderInfoCell
            
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        goDetailVC()
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 2 {
//            return 170
//        }
        return 190
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return kMargin
        }
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.00001
    }
}
