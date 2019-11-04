//
//  JSLConmentDetailVC.swift
//  JSLogistics
//  查看评价
//  Created by gouyz on 2019/11/1.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import Cosmos

class JSLConmentDetailVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "查看评价"
        self.view.backgroundColor = kWhiteColor
        
        setUpUI()
    }
    func setUpUI(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(lineView)
        contentView.addSubview(iconView)
        contentView.addSubview(useNameLab)
        contentView.addSubview(dateLab)
        contentView.addSubview(desLab)
        contentView.addSubview(ratingView)
        contentView.addSubview(desLab1)
        contentView.addSubview(serviceRatingView)
        contentView.addSubview(contentLab)
        contentView.addSubview(imgViews)
        
        scrollView.snp.makeConstraints { (make) in
            make.left.bottom.right.top.equalTo(view)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.width.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            // 这个很重要！！！！！！
            // 必须要比scroll的高度大一，这样才能在scroll没有填充满的时候，保持可以拖动
            make.height.greaterThanOrEqualTo(scrollView).offset(1)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(kMargin)
        }
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.centerY.equalTo(useNameLab)
            make.size.equalTo(CGSize.init(width: kTitleHeight, height: kTitleHeight))
        }
        useNameLab.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(lineView.snp.bottom).offset(kMargin)
            make.height.equalTo(50)
        }
        dateLab.snp.makeConstraints { (make) in
            make.left.equalTo(iconView)
            make.top.equalTo(useNameLab.snp.bottom)
            make.right.equalTo(-kMargin)
            make.height.equalTo(30)
        }
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(iconView)
            make.top.equalTo(dateLab.snp.bottom).offset(kMargin)
            make.width.equalTo(80)
            make.height.equalTo(kTitleHeight)
        }
        ratingView.snp.makeConstraints { (make) in
            make.left.equalTo(desLab.snp.right).offset(kMargin)
            make.centerY.equalTo(desLab)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        desLab1.snp.makeConstraints { (make) in
            make.left.width.height.equalTo(desLab)
            make.top.equalTo(desLab.snp.bottom)
        }
        serviceRatingView.snp.makeConstraints { (make) in
            make.left.equalTo(desLab1.snp.right).offset(kMargin)
            make.centerY.equalTo(desLab1)
            make.width.height.equalTo(ratingView)
        }
        contentLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(dateLab)
            make.top.equalTo(desLab1.snp.bottom).offset(kMargin)
        }
        imgViews.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(contentLab.snp.bottom).offset(kMargin)
            make.right.equalTo(-kMargin)
            make.height.equalTo(0)
            // 这个很重要，viewContainer中的最后一个控件一定要约束到bottom，并且要小于等于viewContainer的bottom
            // 否则的话，上面的控件会被强制拉伸变形
            // 最后的-10是边距，这个可以随意设置
            make.bottom.lessThanOrEqualTo(contentView).offset(-kMargin)
        }
        
    }
    /// scrollView
    var scrollView: UIScrollView = UIScrollView()
    /// 内容View
    var contentView: UIView = UIView()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = kBackgroundColor
        
        return view
    }()
    /// 用户图标
    lazy var iconView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kBackgroundColor
        imgView.cornerRadius = 22
        
        return imgView
    }()
    
    /// 用户名称
    lazy var useNameLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "陈光军"
        
        return lab
    }()
    /// 日期
    lazy var dateLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kGaryFontColor
        lab.text = "2018-12-11 店铺名称"
        
        return lab
    }()
    ///
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "商品评分"
        
        return lab
    }()
    ///星星评分
    lazy var ratingView: CosmosView = {
        
        let ratingStart = CosmosView()
        ratingStart.settings.updateOnTouch = false
        ratingStart.settings.fillMode = .full
        ratingStart.settings.filledColor = kGreenFontColor
        ratingStart.settings.emptyBorderColor = kGreenFontColor
        ratingStart.settings.filledBorderColor = kGreenFontColor
        ratingStart.settings.starMargin = 5
        ratingStart.settings.starSize = 30
        ratingStart.rating = 5
        
        return ratingStart
        
    }()
    ///
    lazy var desLab1 : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "店铺评分"
        
        return lab
    }()
    ///星星评分
    lazy var serviceRatingView: CosmosView = {
        
        let ratingStart = CosmosView()
        ratingStart.settings.updateOnTouch = false
        ratingStart.settings.fillMode = .full
        ratingStart.settings.filledColor = kGreenFontColor
        ratingStart.settings.emptyBorderColor = kGreenFontColor
        ratingStart.settings.filledBorderColor = kGreenFontColor
        ratingStart.settings.starMargin = 5
        ratingStart.settings.starSize = 30
        ratingStart.rating = 5
        
        return ratingStart
        
    }()
    
    /// 评价内容
    lazy var contentLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.numberOfLines = 0
        lab.text = "评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容评价内容"
        
        return lab
    }()
    /// 九宫格图片显示
    lazy var imgViews: GYZPhotoView = GYZPhotoView()

}
