//
//  JSLNoteDetailConmentHeader.swift
//  JSLogistics
//  笔记详情 评论header
//  Created by gouyz on 2019/11/13.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLNoteDetailConmentHeader: UITableViewHeaderFooterView {

    /// 闭包回调
    public var operatorBlock: ((_ tag: Int) ->())?

    override init(reuseIdentifier: String?){
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kBackgroundColor
        setupUI()
        
        zanBtn.set(image: UIImage.init(named: "icon_home_heart"), title: "100", titlePosition: .right, additionalSpacing: 5, state: .normal)
        favouriteBtn.set(image: UIImage.init(named: "icon_favourite"), title: "100", titlePosition: .right, additionalSpacing: 5, state: .normal)
        conmentBtn.set(image: UIImage.init(named: "icon_conment"), title: "100", titlePosition: .right, additionalSpacing: 5, state: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(bgView)
        bgView.addSubview(sharedBtn)
        bgView.addSubview(zanBtn)
        bgView.addSubview(favouriteBtn)
        bgView.addSubview(conmentBtn)
        
        bgView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(kMargin)
        }
        sharedBtn.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.width.equalTo(kTitleHeight)
        }
        conmentBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(sharedBtn)
            make.right.equalTo(-kMargin)
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
        favouriteBtn.snp.makeConstraints { (make) in
            make.top.height.width.equalTo(conmentBtn)
            make.right.equalTo(conmentBtn.snp.left).offset(-5)
        }
        zanBtn.snp.makeConstraints { (make) in
            make.top.height.width.equalTo(conmentBtn)
            make.right.equalTo(favouriteBtn.snp.left).offset(-5)
        }
    }
    lazy var bgView:UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        view.isUserInteractionEnabled = true
        
        return view
    }()
    /// 分享
    lazy var sharedBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "icon_shared"), for: .normal)
        return btn
    }()
    /// 收藏
    lazy var favouriteBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k12Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        return btn
    }()
    /// 评论
    lazy var conmentBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k12Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        return btn
    }()
    /// 点赞
    lazy var zanBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k12Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        return btn
    }()
}
