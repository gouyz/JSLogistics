//
//  JSLStoreDetailVC.swift
//  JSLogistics
//  店铺详情
//  Created by gouyz on 2019/11/15.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD

private let storeDetailMoreHeader = "storeDetailMoreHeader"
private let storeDetailMoreCell = "storeDetailMoreCell"
private let storeDetailGoodsCell = "storeDetailGoodsCell"

class JSLStoreDetailVC: GYZBaseVC {
    
    var dataModel: JSLStoreDetailModel?
    /// 店铺id
    var storeId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "店铺详情"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_shared")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedSharedBtn))
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        tableView.tableHeaderView = headerView
        
        requestDetailInfo()
    }
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = kWhiteColor
        
        // 设置大概高度
        table.estimatedRowHeight = 200
        // 设置行高为自动适配
        table.rowHeight = UITableView.automaticDimension
        
        
        table.register(JSLStoreDetailGoodsCell.classForCoder(), forCellReuseIdentifier: storeDetailGoodsCell)
        table.register(JSLNoteDetailMoreCell.classForCoder(), forCellReuseIdentifier: storeDetailMoreCell)
        
        table.register(JSLNoteDetailMoreHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: storeDetailMoreHeader)
        
        return table
    }()
    
    var headerView:JSLStoreDetailHeaderView = JSLStoreDetailHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth * 0.48))
    
    //店铺详情
    func requestDetailInfo(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("store/store_info", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? "","store_id":storeId],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].dictionaryObject else { return }
                weakSelf?.dataModel = JSLStoreDetailModel.init(dict: data)
                weakSelf?.dealData()
                
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    
    func dealData(){
        if let model = dataModel {
            headerView.bgImgView.kf.setImage(with: URL.init(string: (model.storeInfo?.store_banner)!))
            headerView.nameLab.text = model.storeInfo?.store_name
            headerView.desLab.text = model.storeInfo?.store_tag
            headerView.addressLab.text = model.storeInfo?.address
            tableView.reloadData()
        }
    }
    
    /// 分享
    @objc func clickedSharedBtn(){
        
    }
    
    /// 详情
    func goDetailVC(index : Int){
        let vc = JSLNoteDetailVC()
        vc.noteId = (dataModel?.publishList[index].publish_id)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension JSLStoreDetailVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataModel != nil ? (dataModel?.goodsList.count)! : 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: storeDetailGoodsCell) as! JSLStoreDetailGoodsCell
            
            cell.dataModel = dataModel?.goodsList[indexPath.row]
            
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: storeDetailMoreCell) as! JSLNoteDetailMoreCell
            
            if dataModel != nil {
                cell.dataModel = dataModel?.publishList
            }
            cell.didSelectItemBlock = {[unowned self] (index) in
                self.goDetailVC(index: index)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: storeDetailMoreHeader) as! JSLNoteDetailMoreHeader
        
        if section == 0 {
            headerView.moreLab.text = "推荐美食"
        }else{
            headerView.moreLab.text = "更多美食笔记"
        }
        
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
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
        
        return 0.00001
    }
}
