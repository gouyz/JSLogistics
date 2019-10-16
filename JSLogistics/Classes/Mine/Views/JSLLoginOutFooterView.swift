//
//  JSLLoginOutFooterView.swift
//  JSLogistics
//  退出登录footer
//  Created by gouyz on 2019/10/16.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLLoginOutFooterView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?){
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kWhiteColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(loginOutBtn)
        
        loginOutBtn.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(120)
            make.height.equalTo(kTitleHeight)
        }
    }
    /// 退出登录
    lazy var loginOutBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.backgroundColor = kRedFontColor
        btn.cornerRadius = 22
        btn.setTitle("退 出", for: .normal)
        return btn
    }()

}
