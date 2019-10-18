//
//  JSLAboutHeaderView.swift
//  JSLogistics
//  关于 header
//  Created by gouyz on 2019/10/17.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLAboutHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?){
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kBackgroundColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(logoImgView)
        contentView.addSubview(versionLab)
        
        logoImgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.size.equalTo(CGSize.init(width: 90, height: 90))
            make.top.equalTo(20)
        }
        versionLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(logoImgView.snp.bottom)
            make.height.equalTo(kTitleHeight)
        }
    }
    lazy var logoImgView:UIImageView = {
       let imgView = UIImageView()
        imgView.backgroundColor = kWhiteColor
        imgView.cornerRadius = kCornerRadius
        
        return imgView
    }()
    /// 版本号
    lazy var versionLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.textAlignment = .center
        lab.text = "商城 V1.0.0"
        
        return lab
    }()
}
