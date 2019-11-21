//
//  JSLCartOrderInfoCell.swift
//  JSLogistics
//  购物订单 信息
//  Created by gouyz on 2019/10/30.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLCartOrderInfoCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kWhiteColor
        setupUI()
        
        phoneBtn.set(image: UIImage.init(named: "icon_link_phone"), title: "电话联系", titlePosition: .right, additionalSpacing: kMargin, state: .normal)
        kefuBtn.set(image: UIImage.init(named: "icon_link_kefu"), title: "咨询客服", titlePosition: .right, additionalSpacing: kMargin, state: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(lineView)
        contentView.addSubview(desLab)
        contentView.addSubview(orderNumLab)
        contentView.addSubview(dateLab)
        contentView.addSubview(lineView1)
        contentView.addSubview(lineView2)
        contentView.addSubview(phoneBtn)
        contentView.addSubview(kefuBtn)
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView)
            make.centerY.equalTo(desLab)
            make.width.equalTo(3)
            make.height.equalTo(15)
        }
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp.right).offset(kMargin)
            make.top.equalTo(contentView)
            make.right.equalTo(-kMargin)
            make.height.equalTo(kTitleHeight)
        }
        orderNumLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(desLab)
            make.top.equalTo(desLab.snp.bottom)
            make.height.equalTo(30)
        }
        dateLab.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(orderNumLab)
            make.top.equalTo(orderNumLab.snp.bottom)
        }
        lineView1.snp.makeConstraints { (make) in
            make.right.left.equalTo(contentView)
            make.top.equalTo(dateLab.snp.bottom).offset(40)
            make.height.equalTo(klineWidth)
        }
        phoneBtn.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(lineView1.snp.bottom)
            make.height.equalTo(kTitleHeight)
            make.right.equalTo(lineView2.snp.left)
            make.bottom.equalTo(-5)
        }
        lineView2.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom).offset(5)
            make.centerX.equalTo(contentView)
            make.width.equalTo(klineWidth)
            make.bottom.equalTo(-5)
        }
        kefuBtn.snp.makeConstraints { (make) in
            make.left.equalTo(lineView2.snp.right)
            make.right.equalTo(-kMargin)
            make.top.height.equalTo(phoneBtn)
        }
    }
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = kGreenFontColor
        
        return view
    }()
    ///
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k18Font
        lab.text = "订单信息"
        
        return lab
    }()
    /// 订单编号
    lazy var orderNumLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGaryFontColor
        lab.font = k15Font
        lab.text = "订单编号：12345677777"
        
        return lab
    }()
    /// 创建时间
    lazy var dateLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGaryFontColor
        lab.font = k15Font
        lab.text = "下单时间：2019-10-30 11:00:00"
        
        return lab
    }()
    lazy var lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = kGrayLineColor
        
        return view
    }()
    lazy var lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = kGrayLineColor
        
        return view
    }()
    /// 电话联系
    lazy var phoneBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k18Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        
        return btn
    }()
    /// 咨询客服
    lazy var kefuBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k18Font
        btn.setTitleColor(kGreenFontColor, for: .normal)
        
        return btn
    }()
    
}
