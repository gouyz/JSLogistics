//
//  JSLHomeShopCell.swift
//  JSLogistics
//
//  Created by gouyz on 2019/8/9.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLHomeShopCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgView)
        bgView.addSubview(tagImgView)
        bgView.addSubview(userHeaderImgView)
        bgView.addSubview(nameLab)
        bgView.addSubview(contentLab)
        bgView.addSubview(zanBtn)
        
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        tagImgView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(bgView)
            make.bottom.equalTo(userHeaderImgView.snp.top).offset(-kMargin)
        }
        userHeaderImgView.snp.makeConstraints { (make) in
            make.left.equalTo(contentLab)
            make.bottom.equalTo(contentLab.snp.top).offset(-kMargin)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(userHeaderImgView.snp.right).offset(kMargin)
            make.top.bottom.equalTo(userHeaderImgView)
            make.right.equalTo(contentLab)
        }
        contentLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.bottom.equalTo(zanBtn.snp.top)
            make.height.equalTo(30)
        }
        zanBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.bottom.equalTo(bgView)
            make.size.equalTo(CGSize.init(width: 80, height: 30))
        }
        
        zanBtn.set(image: UIImage.init(named: "icon_home_heart"), title: "2019", titlePosition: .right, additionalSpacing: 5, state: .normal)
        zanBtn.set(image: UIImage.init(named: "icon_home_heart_selected"), title: "2019", titlePosition: .right, additionalSpacing: 5, state: .selected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///背景view
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        view.cornerRadius = kCornerRadius
        
        return view
    }()
    ///tag图片
    lazy var tagImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kBackgroundColor
        imgView.image = UIImage.init(named: "icon_home_food_default")

        return imgView
    }()
    ///用户头像
    lazy var userHeaderImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kBackgroundColor
        imgView.cornerRadius = 20
        
        return imgView
    }()
    ///名称
    lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.numberOfLines = 2
        lab.text = "“烧等”青春，遇见更好的自己"
        
        return lab
    }()
    ///内容
    lazy var contentLab: UILabel = {
        let lab = UILabel()
        lab.font = k12Font
        lab.textColor = kHeightGaryFontColor
        lab.numberOfLines = 2
        lab.text = "想吃火锅却害怕起痘痘上火？来这里，总有一款满足你的味蕾...来这里，总有一款满足你的味蕾..."
        
        return lab
    }()
    /// 点赞
    lazy var zanBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k13Font
        btn.titleLabel?.textAlignment = .right
        btn.setTitleColor(kHeightGaryFontColor, for: .normal)
        return btn
    }()
}
