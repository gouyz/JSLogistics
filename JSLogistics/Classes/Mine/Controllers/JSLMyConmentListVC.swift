//
//  JSLMyConmentListVC.swift
//  JSLogistics
//  我的评价列表
//  Created by gouyz on 2019/10/30.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import JXSegmentedView
import MBProgressHUD

private let myConmentListCartCell = "myConmentListCartCell"
private let myConmentListRunCell = "myConmentListRunCell"

class JSLMyConmentListVC: GYZBaseVC {
    
    weak var naviController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        table.register(JSLCartOrderListCell.classForCoder(), forCellReuseIdentifier: myConmentListCartCell)
        table.register(JSLRunOrderListCell.classForCoder(), forCellReuseIdentifier: myConmentListRunCell)
        
        return table
    }()
    /// 订单详情
    func goDetailVC(){
        let vc = JSLCartOrderDetailVC()
        self.naviController?.pushViewController(vc, animated: true)
    }
    /// 操作
    @objc func onClickedOperator(sender:UIButton){
        goConmentVC()
    }
    // 立即评价
    func goConmentVC(){
        let vc = JSLOrderConmentVC()
        self.naviController?.pushViewController(vc, animated: true)
    }
}
extension JSLMyConmentListVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: myConmentListCartCell) as! JSLCartOrderListCell
            
            cell.operatorBtn.tag = indexPath.row
            cell.operatorBtn.addTarget(self, action: #selector(onClickedOperator(sender:)), for: .touchUpInside)
            
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: myConmentListRunCell) as! JSLRunOrderListCell
            
            cell.operatorBtn.tag = indexPath.row
            cell.operatorBtn.addTarget(self, action: #selector(onClickedOperator(sender:)), for: .touchUpInside)
            
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
        goDetailVC()
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.00001
    }
}
extension JSLMyConmentListVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self.view
    }
    func listDidAppear() {
        
    }
}
