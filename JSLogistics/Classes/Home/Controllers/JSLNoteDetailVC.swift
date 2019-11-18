//
//  JSLNoteDetailVC.swift
//  JSLogistics
//  笔记详情
//  Created by gouyz on 2019/11/7.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD

private let noteDetailInfoCell = "noteDetailInfoCell"
private let noteDetailShopCell = "noteDetailShopCell"
private let noteDetailConmentCell = "noteDetailConmentCell"
private let noteDetailMoreCell = "noteDetailMoreCell"
private let noteDetailMoreHeader = "noteDetailMoreHeader"
private let noteDetailConmentFooter = "noteDetailConmentFooter"
private let noteDetailConmentHeader = "noteDetailConmentHeader"

class JSLNoteDetailVC: GYZBaseVC {
    
    var dataModel: JSLNoteDetailModel?
    /// 更多笔记
    var dataList: [JSLPublishNotesModel] = [JSLPublishNotesModel]()
    /// 笔记id
    var noteId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "笔记详情"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_shared")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedSharedBtn))
        
        view.addSubview(headerView)
        headerView.addSubview(userHeaderImgView)
        headerView.addSubview(nameLab)
        headerView.addSubview(followBtn)
        
        view.addSubview(tableView)
        view.addSubview(sendConmentView)
        sendConmentView.isHidden = true
        sendConmentView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(view)
            make.height.equalTo(kBottomTabbarHeight)
        }
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(view)
            make.height.equalTo(kTabBarHeight)
        }
        
        headerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(view)
            make.height.equalTo(64)
        }
        userHeaderImgView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.centerY.equalTo(headerView)
            make.size.equalTo(CGSize.init(width: kTitleHeight, height: kTitleHeight))
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(userHeaderImgView.snp.right).offset(kMargin)
            make.top.bottom.equalTo(userHeaderImgView)
            make.right.equalTo(followBtn.snp.left).offset(-kMargin)
        }
        followBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.centerY.equalTo(headerView)
            make.size.equalTo(CGSize.init(width: 70, height: 30))
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(-kTabBarHeight)
        }
        
        // 监听键盘隐藏通知
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHide(notification:)),name: UIResponder.keyboardWillHideNotification, object: nil)
        
        bottomView.onClickedOperatorBlock = {[unowned self] (index) in
            
            if index == 101 { // 评论
                self.showConment()
            }else if index == 103 { // 点赞!)
                self.requestZan()
            }else if index == 102 { // 收藏
                self.requestFavourite()
            }
        }
        sendConmentView.sendBtn.addTarget(self, action: #selector(onClickedSend), for: .touchUpInside)
        
        requestDetailInfo()
        requestNotesList()
    }
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        
        // 设置大概高度
        table.estimatedRowHeight = 200
        // 设置行高为自动适配
        table.rowHeight = UITableView.automaticDimension
        
        
        table.register(JSLNoteDetailInfoCell.classForCoder(), forCellReuseIdentifier: noteDetailInfoCell)
        table.register(JSLNoteDetailShopCell.classForCoder(), forCellReuseIdentifier: noteDetailShopCell)
        table.register(JSLNoteDetailConmentCell.classForCoder(), forCellReuseIdentifier: noteDetailConmentCell)
        table.register(JSLNoteDetailMoreCell.classForCoder(), forCellReuseIdentifier: noteDetailMoreCell)
        
        table.register(JSLNoteDetailConmentHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: noteDetailConmentHeader)
        table.register(JSLNoteDetailContentFooter.classForCoder(), forHeaderFooterViewReuseIdentifier: noteDetailConmentFooter)
        table.register(JSLNoteDetailMoreHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: noteDetailMoreHeader)
        
        return table
    }()
    
    lazy var headerView: UIView = {
        let header = UIView()
        header.backgroundColor = kWhiteColor
        header.isUserInteractionEnabled = true
        
        return header
    }()
    ///用户头像
    lazy var userHeaderImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kBackgroundColor
        imgView.cornerRadius = 22
        
        return imgView
    }()
    /// cell title
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "包包"
        
        return lab
    }()
    /// 已关注、回粉
    lazy var followBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.setTitle("已关注", for: .normal)
        btn.backgroundColor = kGreenFontColor
        btn.cornerRadius = 15
        
        btn.addTarget(self, action: #selector(onClickedFollow), for: .touchUpInside)
        
        return btn
    }()
    
    /// 底部评论view
    lazy var bottomView: JSLConmentBottomView = JSLConmentBottomView()
    /// 发送评论view
    lazy var sendConmentView: JSLConmentSendView = JSLConmentSendView()
    
    
    //笔记详情
    func requestDetailInfo(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("publish/getPublishDetail", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? "","publish_id":noteId],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
        
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].dictionaryObject else { return }
                weakSelf?.dataModel = JSLNoteDetailModel.init(dict: data)
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
            userHeaderImgView.kf.setImage(with: URL.init(string: (model.userInfoModel?.head_pic)!))
            nameLab.text = model.userInfoModel?.nickname
            if model.is_concern == "1"{// 已关注
                followBtn.setTitle("已关注", for: .normal)
            }else{
                followBtn.setTitle("+关注", for: .normal)
            }
            
            bottomView.favouriteImgView.isHighlighted = model.is_collect == "1"
            bottomView.zanImgView.isHighlighted = model.is_point == "1"
            tableView.reloadData()
        }
    }
    
    ///获取更多笔记数据
    func requestNotesList(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("publish/getMore",parameters: ["user_id":userDefaults.string(forKey: "userId") ?? ""],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"]["publishList"].array else { return }
                for item in data{
                    guard let itemInfo = item.dictionaryObject else { return }
                    let model = JSLPublishNotesModel.init(dict: itemInfo)
                    
                    weakSelf?.dataList.append(model)
                }
                weakSelf?.tableView.reloadData()
               
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
            
        })
    }
    
    // 键盘隐藏
    @objc func keyboardWillHide(notification: Notification) {
        bottomView.isHidden = false
        sendConmentView.isHidden = true
        self.tableView.snp.updateConstraints { (make) in
            make.bottom.equalTo(-kTabBarHeight)
        }
        //        sendConmentView.contentTxtView.resignFirstResponder()
    }
    /// 显示评论或回复
    func showConment(){
        self.bottomView.isHidden = true
        self.sendConmentView.isHidden = false
        self.tableView.snp.updateConstraints({ (make) in
            make.bottom.equalTo(-kBottomTabbarHeight)
        })
        self.sendConmentView.contentTxtView.text = ""
        //弹出键盘
        self.sendConmentView.contentTxtView.becomeFirstResponder()
    }
    // 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 分享
    @objc func clickedSharedBtn(){
        
    }
    /// 关注、取关
    @objc func onClickedFollow(){
        if dataModel != nil {
            requestFollow()
        }
    }
    
    ///关注/取关
    func requestFollow(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("publish/concern", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? "","concern_user_id":(dataModel?.userInfoModel?.user_id)!],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                let data = response["result"]
                weakSelf?.dataModel?.is_concern = data["status"].stringValue
                weakSelf?.dealData()
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    
    // 发送评论或回复
    @objc func onClickedSend(){
        if sendConmentView.contentTxtView.text.isEmpty {
            MBProgressHUD.showAutoDismissHUD(message: "发送内容不能为空")
            return
        }
        sendConmentView.contentTxtView.resignFirstResponder()
        requestSendConment()
    }
    
    ///发表评论
    func requestSendConment(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("publish/addComment", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? "","publish_id":noteId,"content":sendConmentView.contentTxtView.text!],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                
                let num: Int = Int.init((weakSelf?.dataModel?.comment_count)!)! + 1
                weakSelf?.dataModel?.comment_count = "\(num)"
                weakSelf?.tableView.reloadData()
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    
    // 收藏
    @objc func onClickedFavourite(){
        requestFavourite()
    }
    ///收藏/取消收藏
    func requestFavourite(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("publish/collect", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? "","publish_id":noteId],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                let data = response["result"]
                weakSelf?.dataModel?.is_collect = data["status"].stringValue
                weakSelf?.dataModel?.collect_count = data["count"].stringValue
                weakSelf?.dealData()
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    // 点赞
    @objc func onClickedZan(){
        requestZan()
    }
    
    ///点赞/取消点赞
    func requestZan(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("publish/point", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? "","publish_id":noteId],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                let data = response["result"]
                weakSelf?.dataModel?.is_point = data["status"].stringValue
                weakSelf?.dataModel?.point_count = data["count"].stringValue
                weakSelf?.dealData()
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    /// 全部评论
    @objc func onClickedMoreConment(){
        let vc = JSLNoteAllConmentVC()
        vc.noteId = self.noteId
        vc.resultBlock = {[unowned self] (isRefresh) in
            self.requestDetailInfo()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 店铺详情
    @objc func onClickedStoreDetail(){
        let vc = JSLStoreDetailVC()
        if dataModel != nil {
            vc.storeId = (self.dataModel?.storeInfo?.store_id)!
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 详情
    func goDetailVC(index : Int){
        let vc = JSLNoteDetailVC()
        vc.noteId = dataList[index].publish_id!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension JSLNoteDetailVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            if let model = dataModel {
                return model.conmentList.count
            }
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: noteDetailInfoCell) as! JSLNoteDetailInfoCell
            
            cell.dataModel = dataModel
            
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: noteDetailShopCell) as! JSLNoteDetailShopCell
            
            if dataModel != nil {
                cell.dataModel = dataModel?.storeInfo
            }
            
            cell.bgView.addOnClickListener(target: self, action: #selector(onClickedStoreDetail))
            
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: noteDetailConmentCell) as! JSLNoteDetailConmentCell
            
            cell.dataModel = dataModel?.conmentList[indexPath.row]
            
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: noteDetailMoreCell) as! JSLNoteDetailMoreCell
            
            cell.dataModel = dataList
            cell.didSelectItemBlock = {[unowned self] (index) in
                self.goDetailVC(index: index)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 2 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: noteDetailConmentHeader) as! JSLNoteDetailConmentHeader
            
            headerView.dataModel = dataModel
            headerView.favouriteBtn.addTarget(self, action: #selector(onClickedFavourite), for: .touchUpInside)
            headerView.zanBtn.addTarget(self, action: #selector(onClickedZan), for: .touchUpInside)
            
            return headerView
        }else if section == 3 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: noteDetailMoreHeader) as! JSLNoteDetailMoreHeader
            
            return headerView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            if dataModel?.conmentList.count > 0 {
                let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: noteDetailConmentFooter) as! JSLNoteDetailContentFooter
                
                footerView.moreLab.addOnClickListener(target: self, action: #selector(onClickedMoreConment))
                
                return footerView
            }
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        goDetailVC()
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 {
            if section == 2 {
                return 64
            }else if section == 3 {
                return 54
            }
            return kMargin
        }
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            if let model = dataModel {
                return model.conmentList.count > 0 ? kTitleHeight : 0.00001
            }
            return 0.00001
        }
        return 0.00001
    }
}

