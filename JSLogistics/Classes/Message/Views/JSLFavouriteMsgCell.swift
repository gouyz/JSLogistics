//
//  JSLFavouriteMsgCell.swift
//  JSLogistics
//  赞和收藏 消息cell
//  Created by gouyz on 2019/8/10.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLFavouriteMsgCell: UITableViewCell {
    
    /// 填充数据
    var dataModel : JSLFavouriteMsgModel?{
        didSet{
            if let model = dataModel {
                
                userHeaderImgView.kf.setImage(with: URL.init(string: (model.userInfoModel?.head_pic)!))
                nameLab.text = (model.userInfoModel?.nickname)! + " " + model.desc!
                
                dateLab.text = model.add_time
                tagImgView.kf.setImage(with: URL.init(string: (model.img)!))
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
        contentView.addSubview(tagImgView)
        contentView.addSubview(nameLab)
        contentView.addSubview(userHeaderImgView)
        contentView.addSubview(dateLab)
        
        userHeaderImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(kMargin)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(userHeaderImgView.snp.right).offset(kMargin)
            make.top.equalTo(userHeaderImgView)
            make.right.equalTo(tagImgView.snp.left).offset(-kMargin)
            make.height.equalTo(20)
        }
        dateLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom)
            make.bottom.equalTo(userHeaderImgView)
        }
        tagImgView.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.centerY.equalTo(userHeaderImgView)
            make.size.equalTo(CGSize.init(width: 50, height: 50))
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
        lab.text = "包包 赞美了您的美食笔记"
        
        return lab
    }()
    lazy var dateLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kHeightGaryFontColor
        lab.text = "06-21"
        
        return lab
    }()
}
