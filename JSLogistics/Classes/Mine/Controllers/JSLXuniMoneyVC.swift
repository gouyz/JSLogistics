//
//  JSLXuniMoneyVC.swift
//  JSLogistics
//  虚拟币
//  Created by gouyz on 2019/11/23.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD

private let xuniMoneyMoreHeader = "xuniMoneyMoreHeader"
private let xuniMoneyInfoCell = "xuniMoneyInfoCell"
private let xuniMoneyInfoFooter = "xuniMoneyInfoFooter"
private let xuniMoneyRuleCell = "xuniMoneyRuleCell"

class JSLXuniMoneyVC: GYZBaseVC {
    
    let titlesArr: [String] = ["发布第一篇美食笔记","发布店铺的第一篇美食笔记","成为平台精选笔记","发布更多美食笔记"]
    let InfoArr: [String] = ["+200","+200","+600","+100/篇"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarBgAlpha = 0
        automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_back_white")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedBackBtn))
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            if #available(iOS 11.0, *) {
                make.top.equalTo(-kTitleAndStateHeight)
            }else{
                make.top.equalTo(0)
            }
        }
        tableView.tableHeaderView = headerView
        
        headerView.moneyBtn.addTarget(self, action: #selector(onClickedDetail), for: .touchUpInside)
        
        requestMoneyInfo()
    }
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        
        // 设置大概高度
        table.estimatedRowHeight = 50
        // 设置行高为自动适配
        table.rowHeight = UITableView.automaticDimension
        
        
        table.register(GYZCommonInfoCell.classForCoder(), forCellReuseIdentifier: xuniMoneyInfoCell)
        table.register(JSLXuniMoneyFooterView.classForCoder(), forHeaderFooterViewReuseIdentifier: xuniMoneyInfoFooter)
        table.register(JSLGoodsRuleCell.classForCoder(), forCellReuseIdentifier: xuniMoneyRuleCell)
        table.register(JSLNoteDetailMoreHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: xuniMoneyMoreHeader)
        
        return table
    }()
    
    var headerView:JSLXuniMoneyHeaderView = JSLXuniMoneyHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 160 + kTitleAndStateHeight))
    
    //虚拟币
    func requestMoneyInfo(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("user/user_money", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? ""],  success: {[unowned self] (response) in
            self.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                self.headerView.moneyLab.text = "\(response["result"]["currency_money"].stringValue)=\(response["result"]["user_money"].stringValue)元"
                
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    /// 明细
    @objc func onClickedDetail(){
        let  vc = JSLXuniMoneyDetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension JSLXuniMoneyVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return titlesArr.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: xuniMoneyInfoCell) as! GYZCommonInfoCell
            
            cell.titleLab.text = titlesArr[indexPath.row]
            cell.contentLab.text = InfoArr[indexPath.row]
            cell.titleLab.snp.updateConstraints { (make) in
                make.width.equalTo(kScreenWidth * 0.7)
            }
            cell.contentLab.textColor = kGreenFontColor
            
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: xuniMoneyRuleCell) as! JSLGoodsRuleCell
            
            cell.contentLab.text = "1.虚拟币是APP达人体系中的一种社区福利，可在下单时用于减免支付金额，不兑余额，不找零"
            
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: xuniMoneyMoreHeader) as! JSLNoteDetailMoreHeader
        
        headerView.lineView.isHidden = true
        if section == 0 {
            headerView.moreLab.text = "发布笔记"
            headerView.contentView.backgroundColor = kWhiteColor
        }else{
            headerView.contentView.backgroundColor = kBackgroundColor
            headerView.moreLab.text = "什么是虚拟币？"
        }
        
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: xuniMoneyInfoFooter) as! JSLXuniMoneyFooterView
            
            return footerView
        }
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        goDetailVC()
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 54
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 90
        }
        return 0.00001
    }
    
    //MARK:UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetY = scrollView.contentOffset.y
        let showNavBarOffsetY = kTitleAndStateHeight - topLayoutGuide.length
        
        
        //navigationBar alpha
        if contentOffsetY > showNavBarOffsetY  {
            
            var navAlpha = (contentOffsetY - (showNavBarOffsetY)) / 40.0
            if navAlpha > 1 {
                navAlpha = 1
            }
            self.navigationItem.title = "我的虚拟币"
            navBarBgAlpha = navAlpha
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_back_black")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedBackBtn))
        }else{
            navBarBgAlpha = 0
            self.navigationItem.title = ""
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_back_white")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedBackBtn))
        }
    }
}
