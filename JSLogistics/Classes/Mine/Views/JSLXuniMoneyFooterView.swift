//
//  JSLXuniMoneyFooterView.swift
//  JSLogistics
//  虚拟币 footer
//  Created by gouyz on 2019/11/23.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLXuniMoneyFooterView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?){
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kWhiteColor
        setupUI()
        
        zanBtn.set(image: UIImage.init(named: "icon_money_zan"), title: "点赞", titlePosition: .right, additionalSpacing: 5, state: .normal)
        conmentBtn.set(image: UIImage.init(named: "icon_money_conment"), title: "评论", titlePosition: .right, additionalSpacing: 5, state: .normal)
        favouriteBtn.set(image: UIImage.init(named: "icon_money_favourite"), title: "收藏", titlePosition: .right, additionalSpacing: 5, state: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(zanBtn)
        contentView.addSubview(conmentBtn)
        contentView.addSubview(favouriteBtn)
        contentView.addSubview(moreLab)
        zanBtn.snp.makeConstraints { (make) in
            make.right.equalTo(conmentBtn.snp.left).offset(-kMargin)
            make.top.size.equalTo(conmentBtn)
        }
        conmentBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(20)
            make.size.equalTo(CGSize.init(width: 80, height: 30))
        }
        favouriteBtn.snp.makeConstraints { (make) in
            make.left.equalTo(conmentBtn.snp.right).offset(kMargin)
            make.top.size.equalTo(conmentBtn)
        }
        moreLab.snp.makeConstraints { (make) in
            make.top.equalTo(conmentBtn.snp.bottom).offset(kMargin)
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.bottom.equalTo(-kMargin)
        }
    }
    ///
    lazy var zanBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        
        return btn
    }()
    ///
    lazy var conmentBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        
        return btn
    }()
    ///
    lazy var favouriteBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        
        return btn
    }()
    ///
    lazy var moreLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.textAlignment = .center
        lab.text = "每天最多获得100"
        
        return lab
    }()

}
