//
//  JSLMyProfileHeaderView.swift
//  JSLogistics
//  我的资料 header
//  Created by gouyz on 2019/11/4.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLMyProfileHeaderView: UICollectionReusableView {
    
    var didSelectItemBlock:((_ index: Int) -> Void)?
    
    // MARK: 生命周期方法
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = kWhiteColor
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(nameLab)
        self.addSubview(tagImgView)
        self.addSubview(levelLab)
        self.addSubview(userHeaderImgView)
        self.addSubview(phoneLab)
        self.addSubview(sexLab)
        self.addSubview(addressLab)
        self.addSubview(desLab)
        self.addSubview(contentLab)
        self.addSubview(lineView)
        self.addSubview(titleLab)
        
        userHeaderImgView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(20)
            make.size.equalTo(CGSize.init(width: 90, height: 90))
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(userHeaderImgView.snp.right).offset(kMargin)
            make.top.equalTo(userHeaderImgView)
            make.height.equalTo(40)
        }
        tagImgView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab.snp.right).offset(5)
            make.centerY.equalTo(levelLab)
            make.size.equalTo(CGSize.init(width: 15, height: 12))
        }
        levelLab.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgView.snp.right).offset(3)
            make.centerY.equalTo(nameLab)
            make.height.equalTo(20)
            make.width.equalTo(80)
        }
        phoneLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom)
            make.right.equalTo(-kMargin)
            make.height.equalTo(20)
        }
        sexLab.snp.makeConstraints { (make) in
            make.left.equalTo(phoneLab)
            make.top.equalTo(phoneLab.snp.bottom)
            make.height.equalTo(phoneLab)
            make.width.equalTo(30)
        }
        addressLab.snp.makeConstraints { (make) in
            make.left.equalTo(sexLab.snp.right).offset(5)
            make.top.height.equalTo(sexLab)
            make.right.equalTo(-kMargin)
        }
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(userHeaderImgView)
            make.top.equalTo(userHeaderImgView.snp.bottom).offset(kMargin)
            make.right.equalTo(-kMargin)
            make.height.equalTo(30)
        }
        contentLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(desLab)
            make.top.equalTo(desLab.snp.bottom)
            make.height.equalTo(kTitleHeight)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(contentLab.snp.bottom)
            make.height.equalTo(klineWidth)
        }
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(userHeaderImgView)
            make.top.equalTo(lineView.snp.bottom)
            make.right.equalTo(-kMargin)
            make.height.equalTo(kTitleHeight)
        }
        
    }
    ///用户头像
    lazy var userHeaderImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kBackgroundColor
        imgView.cornerRadius = 45
        
        return imgView
    }()
    ///名称
    lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.boldSystemFont(ofSize: 20)
        lab.textColor = kBlackFontColor
        lab.text = "小美"
        
        return lab
    }()
    ///tag图片
    lazy var tagImgView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_level_diamond"))
    ///等级
    lazy var levelLab: UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kGreenFontColor
        lab.text = "专属等级"
        
        return lab
    }()
    ///电话
    lazy var phoneLab: UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.text = "18711111111"
        
        return lab
    }()
    ///性别
    lazy var sexLab: UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.text = "男"
        
        return lab
    }()
    ///地址
    lazy var addressLab: UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.text = "江苏——常州"
        
        return lab
    }()
    ///个性签名
    lazy var desLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "个性签名"
        
        return lab
    }()
    ///个性签名
    lazy var contentLab: UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kGreenFontColor
        lab.numberOfLines = 0
        lab.text = "这家伙太懒了，还没有个性签名~~"
        
        return lab
    }()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = kGrayLineColor
        
        return view
    }()
    ///
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "精选照片"
        
        return lab
    }()
}
