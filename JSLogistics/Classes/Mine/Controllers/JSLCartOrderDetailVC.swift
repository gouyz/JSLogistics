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
    
    /// 1购物订单2出行订单
    var orderType: String = "1"
    var dataModel: JSLGoodsOrderModel?
    var orderId: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "订单详情"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        requestDetailInfo()
    }
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = kBackgroundColor
        // 设置大概高度
        table.estimatedRowHeight = 180
        // 设置行高为自动适配
        table.rowHeight = UITableView.automaticDimension
        
        table.register(JSLCartOrderListCell.classForCoder(), forCellReuseIdentifier: cartOrderDetailCell)
        table.register(JSLRunOrderListCell.classForCoder(), forCellReuseIdentifier: cartOrderDetailTripCell)
        table.register(JSLCartOrderDetailHeaderCell.classForCoder(), forCellReuseIdentifier: cartOrderDetailHeaderCell)
        table.register(JSLCartOrderInfoCell.classForCoder(), forCellReuseIdentifier: cartOrderDetailInfoCell)
        
        return table
    }()

    //订单详情
    func requestDetailInfo(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("order/getOrderDetail", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? "","order_id":orderId],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
        
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].dictionaryObject else { return }
                weakSelf?.dataModel = JSLGoodsOrderModel.init(dict: data)
                weakSelf?.tableView.reloadData()
            
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    
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
            
            if orderType == "1" {
                if let model = dataModel {
                    cell.statusNameLab.text = model.status_name
                    /// 订单状态1：待使用；2：待评价；3：已取消；4：已完成
                    let status: String = model.order_status!
                    var des: String = "期待您的下次光临"
                    if status == "1" {
                        des = "期待您早日到店使用"
                    }else if status == "2" {
                        des = "期待您的好评"
                    }
                    
                    cell.desLab.text = des
                }
            }
            
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 1{
            
            if orderType == "1" {
                let cell = tableView.dequeueReusableCell(withIdentifier: cartOrderDetailCell) as! JSLCartOrderListCell
                
                cell.dataModel = dataModel
                
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: cartOrderDetailTripCell) as! JSLRunOrderListCell
                
                cell.selectionStyle = .none
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cartOrderDetailInfoCell) as! JSLCartOrderInfoCell
            
            if orderType == "1" {
                if let model = dataModel {
                    cell.orderNumLab.text = "订单编号：\(model.order_sn!)"
                    
                    cell.desLab.text = "下单时间：\(model.add_time!)"
                }
            }
            
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
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        if indexPath.section == 2 {
////            return 170
////        }
//        return 190
//    }
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
