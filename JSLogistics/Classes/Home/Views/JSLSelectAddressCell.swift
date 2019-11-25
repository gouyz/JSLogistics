//
//  JSLSelectAddressCell.swift
//  JSLogistics
//  选择地址
//  Created by gouyz on 2019/11/25.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLSelectAddressCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kWhiteColor
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(nameLab)
        contentView.addSubview(desLab)
        contentView.addSubview(lineView)
        
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.height.equalTo(20)
        }
        desLab.snp.makeConstraints { (make) in
            make.right.left.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom)
            make.height.equalTo(20)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.height.equalTo(klineWidth)
            make.bottom.equalTo(contentView)
        }
        
    }
    
    ///
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGaryFontColor
        lab.font = k15Font
        
        return lab
    }()
    ///
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kHeightGaryFontColor
        lab.font = k12Font
        
        return lab
    }()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = kGrayLineColor
        
        return view
    }()

}
