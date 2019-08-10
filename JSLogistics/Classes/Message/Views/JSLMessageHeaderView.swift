//
//  JSLMessageHeaderView.swift
//  JSLogistics
//  消息header
//  Created by gouyz on 2019/8/10.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLMessageHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?){
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kBackgroundColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(bgView)
        bgView.addSubview(zanView)
        bgView.addSubview(conmentView)
        bgView.addSubview(fensiView)
        
        bgView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(contentView)
            make.bottom.equalTo(-kMargin)
        }
        zanView.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.width.equalTo(50)
            make.top.equalTo(15)
            make.bottom.equalTo(-kMargin)
        }
        conmentView.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgView)
            make.top.bottom.width.equalTo(zanView)
        }
        fensiView.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(zanView)
            make.right.equalTo(-30)
        }
    }
    ///背景view
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        view.isUserInteractionEnabled = true
        
        return view
    }()
    /// 
    lazy var zanView : GYZImgAndTxtBtnView = {
        let btnView = GYZImgAndTxtBtnView()
        btnView.imgSize = CGSize.init(width: 48, height: 48)
        btnView.menuImg.image = UIImage.init(named: "icon_msg_favourite")
        btnView.menuTitle.text = "赞和收藏"
        btnView.menuTitle.font = k12Font
        btnView.tag = 101
        
        return btnView
    }()
    ///
    lazy var conmentView : GYZImgAndTxtBtnView = {
        let btnView = GYZImgAndTxtBtnView()
        btnView.imgSize = CGSize.init(width: 48, height: 48)
        btnView.menuImg.image = UIImage.init(named: "icon_msg_conment")
        btnView.menuTitle.text = "评论"
        btnView.menuTitle.font = k13Font
        btnView.tag = 102
        
        return btnView
    }()
    ///
    lazy var fensiView : GYZImgAndTxtBtnView = {
        let btnView = GYZImgAndTxtBtnView()
        btnView.imgSize = CGSize.init(width: 48, height: 48)
        btnView.menuImg.image = UIImage.init(named: "icon_msg_fensi")
        btnView.menuTitle.text = "粉丝"
        btnView.menuTitle.font = k13Font
        btnView.tag = 103
        
        return btnView
    }()
}
