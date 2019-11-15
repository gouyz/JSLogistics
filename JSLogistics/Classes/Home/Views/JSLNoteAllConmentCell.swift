//
//  JSLNoteAllConmentCell.swift
//  JSLogistics
//  全部评论 cell
//  Created by gouyz on 2019/11/15.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLNoteAllConmentCell: UITableViewCell {
    
    /// 填充数据
    var dataModel : JSLConmentModel?{
        didSet{
            if let model = dataModel {
                
                userImgView.kf.setImage(with: URL.init(string: model.head!))
                
                nameLab.text = model.username
                contentLab.text = model.content
                
                dateLab.text = model.add_time
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kWhiteColor
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(userImgView)
        contentView.addSubview(nameLab)
        contentView.addSubview(dateLab)
        contentView.addSubview(contentLab)
        contentView.addSubview(replyLab)
        
        userImgView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(kMargin)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(userImgView.snp.right).offset(kMargin)
            make.top.equalTo(userImgView)
            make.right.equalTo(-kMargin)
            make.height.equalTo(30)
        }
        contentLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom).offset(5)
        }
        dateLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.top.equalTo(contentLab.snp.bottom).offset(5)
            make.bottom.equalTo(-kMargin)
            make.height.equalTo(20)
        }
        replyLab.snp.makeConstraints { (make) in
            make.left.equalTo(dateLab.snp.right).offset(20)
            make.height.top.equalTo(dateLab)
            make.width.equalTo(60)
        }
        
    }
    
    /// 用户头像图片
    lazy var userImgView : UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kGrayBackGroundColor
        imgView.cornerRadius = 20
        
        return imgView
    }()
    /// 用户名称
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k18Font
        lab.text = "Alison"
        
        return lab
    }()
    /// 日期
    lazy var dateLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGaryFontColor
        lab.font = k13Font
        lab.text = "06-22 13:00"
        
        return lab
    }()
    /// 内容
    lazy var contentLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k13Font
        lab.numberOfLines = 0
        lab.text = "很有效很有效很有效很有效很有效很有效很有效很有效很有效很有效......"
        
        return lab
    }()
    /// 查看更多回复
    lazy var replyLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGaryFontColor
        lab.font = k13Font
        lab.textAlignment = .center
        lab.text = "回复"
        
        return lab
    }()
    
}
