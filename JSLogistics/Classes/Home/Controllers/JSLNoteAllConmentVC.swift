//
//  JSLNoteAllConmentVC.swift
//  JSLogistics
//  全部评论
//  Created by gouyz on 2019/11/15.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD

private let noteAllConmentCell = "noteAllConmentCell"
private let noteAllConmentReplyCell = "noteAllConmentReplyCell"

class JSLNoteAllConmentVC: GYZBaseVC {
    
    /// 选择结果回调
    var resultBlock:((_ isRefesh: Bool) -> Void)?
    var isModify:Bool = false
    
    var dataList: [JSLConmentModel] = [JSLConmentModel]()
    /// 笔记id
    var noteId:String = ""
    /// 是否是回复
    var isReply: Bool = false
    /// 回复评论id（一条评论下面的所有回复都是同一个父类id：第一评论id）
    var commentId: String = ""
    /// 要回复人的id
    var replyUserId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "全部评论"
        view.addSubview(sendConmentView)
        sendConmentView.isHidden = true
        sendConmentView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(view)
            make.height.equalTo(kBottomTabbarHeight)
        }
        view.addSubview(bottomView)
        bottomView.favouriteImgView.isHidden = true
        bottomView.zanImgView.isHidden = true
        bottomView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(view)
            make.height.equalTo(kTabBarHeight)
        }
        bottomView.favouriteImgView.snp.updateConstraints { (make) in
            make.width.equalTo(0)
        }
        bottomView.zanImgView.snp.updateConstraints { (make) in
            make.width.equalTo(0)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-kTabBarHeight)
            make.left.right.equalTo(view)
            if #available(iOS 11.0, *) {
                make.top.equalTo(view)
            }else{
                make.top.equalTo(kTitleAndStateHeight)
            }
        }
        
        // 监听键盘隐藏通知
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHide(notification:)),name: UIResponder.keyboardWillHideNotification, object: nil)
        
        bottomView.onClickedOperatorBlock = {[unowned self] (index) in
            
            if index == 101 { // 评论
                self.isReply = false
                self.showConment()
            }
        }
        sendConmentView.sendBtn.addTarget(self, action: #selector(onClickedSend), for: .touchUpInside)
        
        requestAllConmentList()
    }
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorColor = kGrayLineColor
        table.backgroundColor = kWhiteColor
        
        // 设置大概高度
        table.estimatedRowHeight = 100
        // 设置行高为自动适配
        table.rowHeight = UITableView.automaticDimension
        
        table.register(JSLNoteAllConmentCell.classForCoder(), forCellReuseIdentifier: noteAllConmentCell)
        table.register(JSLNoteAllConmentReplyCell.classForCoder(), forCellReuseIdentifier: noteAllConmentReplyCell)
        
        return table
    }()
    /// 底部评论view
    lazy var bottomView: JSLConmentBottomView = JSLConmentBottomView()
    /// 发送评论view
    lazy var sendConmentView: JSLConmentSendView = JSLConmentSendView()
    
    /// 重写返回
    override func clickedBackBtn() {
        if resultBlock != nil {
            resultBlock!(isModify)
        }
        
        super.clickedBackBtn()
    }
    
    ///获取笔记评论数据
    func requestAllConmentList(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        showLoadingView()
        
        GYZNetWork.requestNetwork("publish/getComments",parameters: ["publish_id":noteId],  success: { (response) in
            
            weakSelf?.hiddenLoadingView()
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].array else { return }
                for item in data{
                    guard let itemInfo = item.dictionaryObject else { return }
                    let model = JSLConmentModel.init(dict: itemInfo)
                    
                    weakSelf?.dataList.append(model)
                }
                weakSelf?.tableView.reloadData()
                if weakSelf?.dataList.count > 0{
                    weakSelf?.hiddenEmptyView()
                }else{
                    weakSelf?.showEmptyView(content: "暂无评论，请点击重新加载", reload: {
                        weakSelf?.hiddenEmptyView()
                        weakSelf?.refresh()
                    })
                }
                
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hiddenLoadingView()
            GYZLog(error)
            
            weakSelf?.showEmptyView(content: "加载失败，请点击重新加载", reload: {
                weakSelf?.hiddenEmptyView()
                weakSelf?.refresh()
            })
            
        })
    }
    
    // MARK: - 上拉加载更多/下拉刷新
    /// 下拉刷新
    func refresh(){
        dataList.removeAll()
        tableView.reloadData()
        requestAllConmentList()
    }
    // 键盘隐藏
    @objc func keyboardWillHide(notification: Notification) {
        bottomView.isHidden = false
        sendConmentView.isHidden = true
        self.tableView.snp.updateConstraints { (make) in
            make.bottom.equalTo(-kTabBarHeight)
        }
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
    /// 回复评论
    @objc func onClickedReply2Conment(sender:UITapGestureRecognizer){
        let tag = sender.view?.tag
        commentId = dataList[tag!].comment_id!
        replyUserId = dataList[tag!].user_id!
        isReply = true
        showConment()
        
    }
    /// 回复评论的回复
    @objc func onClickedReply2Reply(sender:UITapGestureRecognizer){
        let row = sender.view?.tag
        let section: Int = Int.init((sender.view?.accessibilityIdentifier)!)!
        commentId = dataList[section].replyList[row!].parent_id!
        replyUserId = dataList[section].replyList[row!].user_id!
        isReply = true
        showConment()
        
    }
    // 发送评论
    @objc func onClickedSend(){
        if sendConmentView.contentTxtView.text.isEmpty {
            MBProgressHUD.showAutoDismissHUD(message: "发送内容不能为空")
            return
        }
        sendConmentView.contentTxtView.resignFirstResponder()
        if isReply {//回复
            requestSendConmentReply()
        }else{//评论
            requestSendConment()
        }
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
                weakSelf?.isModify = true
                weakSelf?.refresh()
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    ///发表评论的回复
    func requestSendConmentReply(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("publish/replyComment", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? "","publish_id":noteId,"content":sendConmentView.contentTxtView.text!,"comment_id":commentId,"reply_user_id":replyUserId],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                weakSelf?.isModify = true
                weakSelf?.refresh()
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
}
extension JSLNoteAllConmentVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList[section].replyList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: noteAllConmentCell) as! JSLNoteAllConmentCell
            
            cell.dataModel = dataList[indexPath.section]
            cell.replyLab.tag = indexPath.section
            cell.replyLab.addOnClickListener(target: self, action: #selector(onClickedReply2Conment(sender:)))
            
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: noteAllConmentReplyCell) as! JSLNoteAllConmentReplyCell
            
            cell.dataModel = dataList[indexPath.section].replyList[indexPath.row - 1]
            cell.replyLab.tag = indexPath.row - 1
            cell.replyLab.accessibilityIdentifier = "\(indexPath.section)"
            cell.replyLab.addOnClickListener(target: self, action: #selector(onClickedReply2Reply(sender:)))
            
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
        
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
