//
//  JSLMessageVC.swift
//  JSLogistics
//  消息
//  Created by gouyz on 2019/8/7.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD

private let messageCell = "messageCell"
private let messageHeader = "messageHeader"

class JSLMessageVC: GYZBaseVC {
    
    var dataModel: JSLMessageHomeModel?

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
    
    //消息
    func requestMsgInfo(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("message/index", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? ""],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
        
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].dictionaryObject else { return }
                weakSelf?.dataModel = JSLMessageHomeModel.init(dict: data)
                weakSelf?.tableView.reloadData()
            
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    
    func goOperatorVC(tag: Int){
        switch tag {
        case 1://  赞和收藏
            let vc = JSLFavouriteMsgVC()
            navigationController?.pushViewController(vc, animated: true)
        case 2://  评论
            let vc = JSLFavouriteMsgVC()
            navigationController?.pushViewController(vc, animated: true)
        case 3://  粉丝
            let vc = JSLFenSiMsgListVC()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    /// 通知消息
    func goNotificateVC(){
        let vc = JSLNotificateMsgVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    /// 关注消息
    func goFollowMsgVC(){
        let vc = JSLFollowMsgVC()
        navigationController?.pushViewController(vc, animated: true)
    }
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
            if dataModel != nil  {
                cell.desLab.text = dataModel?.notificationModel?.desc
            }
        }else{
            cell.tagImgView.image = UIImage.init(named: "icon_msg_care")
            cell.dateLab.isHidden = false
            cell.nameLab.text = "关注消息"
            if dataModel != nil  {
                cell.desLab.text = (dataModel?.followMsgModel?.concern_nickname)! + " " + (dataModel?.followMsgModel?.desc)!
            }
        }
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: messageHeader) as! JSLMessageHeaderView
        headerView.operatorBlock = {[weak self] (tag) in
            self?.goOperatorVC(tag: tag)
        }
        
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {// 通知消息
            goNotificateVC()
        }else{ // 关注消息
            goFollowMsgVC()
        }
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
