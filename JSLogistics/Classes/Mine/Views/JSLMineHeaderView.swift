//
//  JSLMineHeaderView.swift
//  JSLogistics
//  我的 header
//  Created by gouyz on 2019/9/2.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLMineHeaderView: UIView {
    
    var didSelectItemBlock:((_ index: Int) -> Void)?

    // MARK: 生命周期方法
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = kWhiteColor
        setupUI()
        
        moneyBtn.set(image: UIImage.init(named: "icon_my_money"), title: "我的虚拟币", titlePosition: .bottom, additionalSpacing: 5, state: .normal)
        orderBtn.set(image: UIImage.init(named: "icon_my_order"), title: "我的订单", titlePosition: .bottom, additionalSpacing: 5, state: .normal)
        conmentBtn.set(image: UIImage.init(named: "icon_my_conment"), title: "我的评论", titlePosition: .bottom, additionalSpacing: 5, state: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(nameLab)
        self.addSubview(tagImgView)
        self.addSubview(levelLab)
        self.addSubview(userHeaderImgView)
        self.addSubview(desLab)
        self.addSubview(fenSiView)
        self.addSubview(followView)
        self.addSubview(zanView)
        self.addSubview(favouriteView)
        
        self.addSubview(bgView)
        bgView.addSubview(moneyBtn)
        bgView.addSubview(orderBtn)
        bgView.addSubview(conmentBtn)
        
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(kMargin)
            make.height.equalTo(30)
        }
        tagImgView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab.snp.right).offset(5)
            make.centerY.equalTo(levelLab)
            make.size.equalTo(CGSize.init(width: 15, height: 12))
        }
        levelLab.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgView.snp.right).offset(3)
            make.top.equalTo(nameLab)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom).offset(kMargin)
            make.right.equalTo(userHeaderImgView.snp.left).offset(-kMargin)
            make.height.equalTo(30)
        }
        userHeaderImgView.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.top.equalTo(nameLab)
            make.size.equalTo(CGSize.init(width: 60, height: 60))
        }
        
        fenSiView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.top.equalTo(desLab.snp.bottom).offset(kMargin)
            make.width.equalTo(followView)
            make.height.equalTo(kTitleHeight)
        }
        followView.snp.makeConstraints { (make) in
            make.left.equalTo(fenSiView.snp.right).offset(5)
            make.top.height.equalTo(fenSiView)
            make.width.equalTo(zanView)
        }
        zanView.snp.makeConstraints { (make) in
            make.left.equalTo(followView.snp.right).offset(5)
            make.top.height.equalTo(fenSiView)
            make.width.equalTo(favouriteView)
        }
        favouriteView.snp.makeConstraints { (make) in
            make.left.equalTo(zanView.snp.right).offset(5)
            make.top.height.equalTo(fenSiView)
            make.width.equalTo(fenSiView)
            make.right.equalTo(desLab)
        }
        
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.right.equalTo(userHeaderImgView)
            make.top.equalTo(fenSiView.snp.bottom).offset(kMargin)
            make.height.equalTo(70)
        }
        moneyBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.width.bottom.top.equalTo(orderBtn)
        }
        orderBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgView)
            make.top.equalTo(bgView)
            make.width.equalTo(80)
            make.bottom.equalTo(bgView)
        }
        conmentBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.width.bottom.top.equalTo(orderBtn)
        }
    }
    ///用户头像
    lazy var userHeaderImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kBackgroundColor
        imgView.cornerRadius = 30
        imgView.tag = 108
        imgView.addOnClickListener(target: self, action: #selector(onClickedList(sender:)))
        
        return imgView
    }()
    ///名称
    lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.boldSystemFont(ofSize: 20)
        lab.textColor = kBlackFontColor
        lab.text = "小美"
        
        return lab
    }()
    ///tag图片
    lazy var tagImgView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_level_diamond"))
    ///等级
    lazy var levelLab: UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kGreenFontColor
        lab.text = "专属等级"
        
        return lab
    }()
    ///简介
    lazy var desLab: UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.text = "这家伙太懒了，还没有个人介绍~~"
        
        return lab
    }()
    /// 粉丝
    lazy var fenSiView: GYZLabAndLabBtnView = {
        let btnView = GYZLabAndLabBtnView()
        btnView.countLab.text = "600"
        btnView.desLab.text = "粉丝"
        
        btnView.tag = 101
        btnView.addOnClickListener(target: self, action: #selector(onClickedList(sender:)))
        
        return btnView
    }()
    /// 关注
    lazy var followView: GYZLabAndLabBtnView = {
        let btnView = GYZLabAndLabBtnView()
        btnView.countLab.text = "600"
        btnView.desLab.text = "关注"
        btnView.tag = 102
        btnView.addOnClickListener(target: self, action: #selector(onClickedList(sender:)))
        
        return btnView
    }()
    /// 赞
    lazy var zanView: GYZLabAndLabBtnView = {
        let btnView = GYZLabAndLabBtnView()
        btnView.countLab.text = "600"
        btnView.desLab.text = "赞"
        btnView.tag = 103
        btnView.addOnClickListener(target: self, action: #selector(onClickedList(sender:)))
        
        return btnView
    }()
    /// 收藏
    lazy var favouriteView: GYZLabAndLabBtnView = {
        let btnView = GYZLabAndLabBtnView()
        btnView.countLab.text = "600"
        btnView.desLab.text = "收藏"
        btnView.tag = 104
        btnView.addOnClickListener(target: self, action: #selector(onClickedList(sender:)))
        
        return btnView
    }()
    ///背景view
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        view.isUserInteractionEnabled = true
        
        view.layer.shadowColor = kGaryFontColor.cgColor
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowOpacity = 0.5
        view.layer.cornerRadius = kCornerRadius
        
        return view
    }()
    /// 我的虚拟币
    lazy var moneyBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k13Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        btn.tag = 105
        btn.addTarget(self, action: #selector(onClickedOperator(sender:)), for: .touchUpInside)
        return btn
    }()
    /// 我的评论
    lazy var conmentBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k13Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        btn.tag = 106
        btn.addTarget(self, action: #selector(onClickedOperator(sender:)), for: .touchUpInside)
        return btn
    }()
    /// 我的订单
    lazy var orderBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k13Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        btn.tag = 107
        btn.addTarget(self, action: #selector(onClickedOperator(sender:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func onClickedList(sender:UITapGestureRecognizer){
        onClickedSelect(index: (sender.view?.tag)!)
    }
    @objc func onClickedOperator(sender:UIButton){
        onClickedSelect(index: sender.tag)
    }
    
    func onClickedSelect(index: Int){
        if didSelectItemBlock != nil {
            didSelectItemBlock!(index)
        }
    }
}
