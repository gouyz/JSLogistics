//
//  JSLFenSiMsgListCell.swift
//  JSLogistics
//  粉丝列表 cell
//  Created by gouyz on 2019/8/11.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLFenSiMsgListCell: UITableViewCell {

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
        contentView.addSubview(userHeaderImgView)
        contentView.addSubview(dateLab)
        contentView.addSubview(operatorBtn)
        
        userHeaderImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(kMargin)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(userHeaderImgView.snp.right).offset(kMargin)
            make.top.equalTo(userHeaderImgView)
            make.right.equalTo(operatorBtn.snp.left).offset(-kMargin)
            make.height.equalTo(20)
        }
        dateLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom)
            make.bottom.equalTo(userHeaderImgView)
        }
        operatorBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.centerY.equalTo(userHeaderImgView)
            make.size.equalTo(CGSize.init(width: 60, height: 34))
        }
    }
    ///tag图片
    lazy var tagImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kBackgroundColor
        imgView.cornerRadius = kCornerRadius
        
        return imgView
    }()
    ///用户头像
    lazy var userHeaderImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kBackgroundColor
        imgView.cornerRadius = 20
        
        return imgView
    }()
    /// cell title
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "包包 关注了你"
        
        return lab
    }()
    lazy var dateLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kHeightGaryFontColor
        lab.text = "06-21"
        
        return lab
    }()
    /// 已关注、回粉
    lazy var operatorBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kGreenFontColor, for: .normal)
        btn.setTitleColor(kWhiteColor, for: .selected)
        btn.setTitle("已关注", for: .normal)
        btn.setTitle("回粉", for: .selected)
        btn.backgroundColor = kWhiteColor
        btn.cornerRadius = 8
        btn.borderColor = kGreenFontColor
        btn.borderWidth = klineWidth
        
        return btn
    }()
}
