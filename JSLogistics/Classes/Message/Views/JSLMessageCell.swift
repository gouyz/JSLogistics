//
//  JSLMessageCell.swift
//  JSLogistics
//  消息cell
//  Created by gouyz on 2019/8/10.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLMessageCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kWhiteColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(tagImgView)
        contentView.addSubview(nameLab)
        contentView.addSubview(desLab)
        contentView.addSubview(dateLab)
        
        tagImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(kMargin)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgView.snp.right).offset(kMargin)
            make.top.equalTo(tagImgView)
            make.right.equalTo(dateLab.snp.left).offset(-kMargin)
            make.height.equalTo(20)
        }
        dateLab.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.top.height.equalTo(nameLab)
            make.width.equalTo(80)
        }
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.right.equalTo(-kMargin)
            make.top.equalTo(nameLab.snp.bottom)
            make.bottom.equalTo(tagImgView)
        }
    }
    /// 图片
    lazy var tagImgView : UIImageView = UIImageView()
    /// cell title
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        
        return lab
    }()
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kHeightGaryFontColor
        
        return lab
    }()
    lazy var dateLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kHeightGaryFontColor
        lab.textAlignment = .right
        lab.text = "03:29"
        
        return lab
    }()
}

