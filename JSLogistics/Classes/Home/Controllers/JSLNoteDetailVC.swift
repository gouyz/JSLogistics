//
//  JSLNoteDetailVC.swift
//  JSLogistics
//  笔记详情
//  Created by gouyz on 2019/11/7.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

private let noteDetailInfoCell = "noteDetailInfoCell"
private let noteDetailShopCell = "noteDetailShopCell"
private let noteDetailConmentCell = "noteDetailConmentCell"
private let noteDetailMoreCell = "noteDetailMoreCell"
private let noteDetailMoreHeader = "noteDetailMoreHeader"

private let noteDetailConmentHeader = "noteDetailConmentHeader"

class JSLNoteDetailVC: GYZBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "笔记详情"
        
        view.addSubview(headerView)
        headerView.addSubview(userHeaderImgView)
        headerView.addSubview(nameLab)
        headerView.addSubview(followBtn)
        
        view.addSubview(tableView)
        
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
            make.left.right.bottom.equalTo(view)
        }
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
//        table.register(JSLCartOrderInfoCell.classForCoder(), forCellReuseIdentifier: cartOrderDetailInfoCell)
        
        table.register(JSLNoteDetailConmentHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: noteDetailConmentHeader)
        
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
        btn.setTitle("+关注", for: .selected)
        btn.backgroundColor = kGreenFontColor
        btn.cornerRadius = 15
        
        return btn
    }()
    
}
extension JSLNoteDetailVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 3
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: noteDetailInfoCell) as! JSLNoteDetailInfoCell
            
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: noteDetailShopCell) as! JSLNoteDetailShopCell
            
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: noteDetailConmentCell) as! JSLNoteDetailConmentCell
            
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 2 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: noteDetailConmentHeader) as! JSLNoteDetailConmentHeader
            
            return headerView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
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
            }
            return kMargin
        }
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.00001
    }
}

