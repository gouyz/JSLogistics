//
//  GYZCommonArrowCell.swift
//  pureworks
//  基本信息cell 只包含左右2个label及右侧箭头
//  Created by gouyz on 2018/6/8.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class GYZCommonArrowCell: UITableViewCell {
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
        contentView.addSubview(contentLab)
        contentView.addSubview(rightIconView)
        contentView.addSubview(lineView)
        
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.centerY.equalTo(contentView)
            make.height.equalTo(kTitleHeight)
            make.width.equalTo(120)
        }
        contentLab.snp.makeConstraints { (make) in
            make.right.equalTo(rightIconView.snp.left).offset(-kMargin)
            make.left.equalTo(nameLab.snp.right).offset(5)
            make.bottom.equalTo(lineView.snp.top).offset(-5)
            make.top.equalTo(5)
            make.height.greaterThanOrEqualTo(34)
        }
        rightIconView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(-kMargin)
            make.size.equalTo(rightArrowSize)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(contentView)
            make.height.equalTo(klineWidth)
        }
    }
    
    /// cell title
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        
        return lab
    }()
    
    /// 内容
    var contentLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.numberOfLines = 0
        lab.textAlignment = .right
        
        return lab
    }()
    /// 右侧箭头图标
    lazy var rightIconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_right_arrow"))
    
    /// 分割线
    var lineView : UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        return line
    }()
}
