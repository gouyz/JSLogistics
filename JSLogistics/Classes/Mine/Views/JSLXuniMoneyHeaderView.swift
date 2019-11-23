//
//  JSLXuniMoneyHeaderView.swift
//  JSLogistics
//  虚拟币header
//  Created by gouyz on 2019/11/23.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLXuniMoneyHeaderView: UIView {
    
    // MARK: 生命周期方法
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = kGreenFontColor
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(titleLab)
        self.addSubview(desLab)
        self.addSubview(moneyBtn)
        self.addSubview(moneyLab)
        self.addSubview(desLab1)
        
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(kStateHeight)
            make.width.equalTo(100)
            make.height.equalTo(kTitleHeight)
        }
        moneyBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.top.equalTo(kTitleAndStateHeight + kMargin)
            make.size.equalTo(CGSize.init(width: 60, height: 30))
        }
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(moneyBtn.snp.bottom)
            make.right.equalTo(-kMargin)
            make.height.equalTo(20)
        }
        moneyLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(desLab)
            make.top.equalTo(desLab.snp.bottom).offset(kMargin)
            make.height.equalTo(kTitleHeight)
        }
        desLab1.snp.makeConstraints { (make) in
            make.left.right.equalTo(desLab)
            make.top.equalTo(moneyLab.snp.bottom).offset(kMargin)
            make.bottom.equalTo(-kMargin)
        }
        
    }
    ///
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = k18Font
        lab.textColor = kWhiteColor
        lab.textAlignment = .center
        lab.text = "我的虚拟币"
        
        return lab
    }()
    ///
    lazy var desLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kWhiteColor
        lab.textAlignment = .center
        lab.text = "当前虚拟币"
        
        return lab
    }()
    /// 我的虚拟币明细
    lazy var moneyBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kGreenFontColor, for: .normal)
        btn.setTitle("明细", for: .normal)
        btn.backgroundColor = kWhiteColor
        btn.cornerRadius = 15
        
        return btn
    }()
    ///
    lazy var moneyLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.boldSystemFont(ofSize: 20)
        lab.textColor = kWhiteColor
        lab.textAlignment = .center
        lab.text = "1223=12.23元"
        
        return lab
    }()
    ///简介
    lazy var desLab1: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kWhiteColor
        lab.textAlignment = .center
        lab.text = "如何获得虚拟币"
        
        return lab
    }()
}
