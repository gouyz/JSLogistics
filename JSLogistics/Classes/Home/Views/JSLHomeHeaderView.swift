//
//  JSLHomeHeaderView.swift
//  JSLogistics
//  首页搜索、广告
//  Created by gouyz on 2019/8/8.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLHomeHeaderView: UIView {

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
        self.addSubview(searchView)
        self.addSubview(adsImgView)
        
        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(self)
            make.height.equalTo(kTitleHeight)
        }
        adsImgView.snp.makeConstraints { (make) in
            make.left.right.equalTo(searchView)
            make.top.equalTo(searchView.snp.bottom)
            make.bottom.equalTo(self)
        }
    }
    /// 广告轮播图
    lazy var adsImgView: ZCycleView = {
        let adsView = ZCycleView()
        adsView.placeholderImage = UIImage.init(named: "icon_home_banner")
        adsView.setImagesGroup([#imageLiteral(resourceName: "icon_home_banner"),#imageLiteral(resourceName: "icon_home_banner"),#imageLiteral(resourceName: "icon_home_banner")])
        adsView.pageControlAlignment = .center
        adsView.pageControlIndictirColor = kWhiteColor
        adsView.pageControlCurrentIndictirColor = kGreenFontColor
        adsView.scrollDirection = .horizontal
        adsView.isAutomatic = false
        
        return adsView
    }()
    /// 搜索
    lazy var searchView: GYZSearchBtnView = GYZSearchBtnView()
}
