//
//  JSLGoodsDetailHeaderView.swift
//  JSLogistics
//  商品详情 header
//  Created by gouyz on 2019/11/19.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLGoodsDetailHeaderView: UIView {

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
        self.addSubview(adsImgView)
        self.addSubview(bgView)
        bgView.addSubview(nameLab)
        bgView.addSubview(priceLab)
        
        adsImgView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(kScreenWidth)
        }
        bgView.snp.makeConstraints { (make) in
            make.left.right.equalTo(adsImgView)
            make.top.equalTo(adsImgView.snp.bottom).offset(kMargin)
            make.height.equalTo(80)
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(bgView)
            make.right.equalTo(-kMargin)
            make.height.equalTo(kTitleHeight)
        }
        priceLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.bottom.equalTo(-kMargin)
            make.top.equalTo(nameLab.snp.bottom)
            make.right.equalTo(nameLab)
        }
        
    }
    /// 广告轮播图
    lazy var adsImgView: ZCycleView = {
        let adsView = ZCycleView()
        adsView.isAutomatic = false
        adsView.placeholderImage = UIImage.init(named: "icon_home_banner")
        adsView.setImagesGroup([#imageLiteral(resourceName: "icon_home_banner"),#imageLiteral(resourceName: "icon_home_banner"),#imageLiteral(resourceName: "icon_home_banner")])
        adsView.pageControlAlignment = .center
        adsView.pageControlIndictirColor = kWhiteColor
        adsView.pageControlCurrentIndictirColor = kGreenFontColor
        adsView.scrollDirection = .horizontal
        
        return adsView
    }()
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        
        return view
    }()
    ///名称
    lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.numberOfLines = 2
        lab.text = "超级好吃的美味烧烤 牧马人双人餐 牧马人双人餐"
        
        return lab
    }()
    /// 原价
    lazy var priceLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kHeightGaryFontColor
        lab.text = "￥88.00"
        
        return lab
    }()
}
