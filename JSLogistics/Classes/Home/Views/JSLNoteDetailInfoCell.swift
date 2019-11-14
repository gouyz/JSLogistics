//
//  JSLNoteDetailInfoCell.swift
//  JSLogistics
//  笔记详情 信息cell
//  Created by gouyz on 2019/11/13.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import Cosmos

class JSLNoteDetailInfoCell: UITableViewCell {
    
    /// 填充数据
    var dataModel : JSLNoteDetailModel?{
        didSet{
            if let model = dataModel {
                
                adsImgView.setUrlsGroup((model.publishInfo?.imgList)!)
                tagImgView.kf.setImage(with: URL.init(string: (model.goodsInfo?.original_img)!))
                
                nameLab.text = model.goodsInfo?.goods_name
                let priceStr = String(format:"%.2f",Float((model.goodsInfo?.shop_price)!)!)
                let marketPrice = String(format:"%.2f",Float((model.goodsInfo?.market_price)!)!)
                let str = "￥\(priceStr)"  + "  \(marketPrice)"
                let priceAtt : NSMutableAttributedString = NSMutableAttributedString(string: str)
                priceAtt.addAttribute(NSAttributedString.Key.foregroundColor, value: kRedFontColor, range: NSMakeRange(0, priceStr.count + 1))
                priceAtt.addAttribute(NSAttributedString.Key.font, value: k18Font, range: NSMakeRange(0, priceStr.count + 1))
                priceAtt.addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: NSMakeRange(str.count - marketPrice.count - 1, marketPrice.count + 1))
                priceAtt.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(str.count - marketPrice.count - 1, marketPrice.count + 1))
                
                priceLab.attributedText = priceAtt
                
                titleLab.text = model.publishInfo?.title
                contentLab.text = model.publishInfo?.content
                ratingView.rating = Double.init((model.publishInfo?.exponent)!)!
                dateLab.text = "发布于\((model.publishInfo?.publish_time)!)"
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
        contentView.addSubview(adsImgView)
        contentView.addSubview(bgView)
        bgView.addSubview(tagImgView)
        bgView.addSubview(nameLab)
        bgView.addSubview(priceLab)
        bgView.addSubview(operatorBtn)
        contentView.addSubview(titleLab)
        contentView.addSubview(contentLab)
        contentView.addSubview(desLab)
        contentView.addSubview(ratingView)
        contentView.addSubview(dateLab)
        
        adsImgView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(kScreenWidth * 1.2)
        }
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(adsImgView.snp.bottom).offset(kMargin)
            make.height.equalTo(90)
        }
        tagImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView)
            make.left.equalTo(kMargin)
            make.size.equalTo(CGSize.init(width: 60, height: 60))
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgView.snp.right).offset(kMargin)
            make.top.equalTo(tagImgView)
            make.right.equalTo(-kMargin)
            make.height.equalTo(40)
        }
        priceLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.bottom.equalTo(tagImgView)
            make.top.equalTo(nameLab.snp.bottom)
            make.right.equalTo(operatorBtn.snp.left).offset(-kMargin)
        }
        operatorBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.bottom.equalTo(priceLab)
            make.size.equalTo(CGSize.init(width: 60, height: 30))
        }
        titleLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(bgView)
            make.height.equalTo(30)
            make.top.equalTo(bgView.snp.bottom).offset(5)
        }
        contentLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(kMargin)
        }
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(contentLab)
            make.top.equalTo(contentLab.snp.bottom).offset(kMargin)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        ratingView.snp.makeConstraints { (make) in
            make.left.equalTo(desLab.snp.right)
            make.centerY.equalTo(desLab)
            make.height.equalTo(20)
            make.width.equalTo(160)
        }
        dateLab.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.top.equalTo(desLab.snp.bottom)
            make.height.equalTo(20)
            make.left.equalTo(kMargin)
            make.bottom.equalTo(-kMargin)
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
        view.cornerRadius = kCornerRadius
        view.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 8
        view.layer.shadowColor = kGrayLineColor.cgColor
        view.borderColor = kWhiteColor
        view.borderWidth = klineWidth
        // true的情况不出阴影效果
        view.layer.masksToBounds = false
        
        return view
    }()
    ///tag图片
    lazy var tagImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kBackgroundColor
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.cornerRadius = kCornerRadius
        imgView.image = UIImage.init(named: "icon_home_food_default")

        return imgView
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
    /// 砍价、已抢光
    lazy var operatorBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.setTitle("砍价", for: .normal)
        btn.backgroundColor = kGreenFontColor
        btn.cornerRadius = 8
        btn.isHidden = true
        
        return btn
    }()
    
    /// 笔记标题
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "超级好吃的美味烧烤"
        
        return lab
    }()
    /// 笔记内容
    lazy var contentLab: UILabel = {
        let lab = UILabel()
        lab.font = k12Font
        lab.textColor = kGaryFontColor
        lab.numberOfLines = 0
        lab.text = "超级好吃的美味烧烤，超级好吃的美味烧烤，超级好吃的美味烧烤，超级好吃的美味烧烤，超级好吃的美味烧烤，超级好吃的美味烧烤，超级好吃的美味烧烤"
        
        return lab
    }()
    ///
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "推荐指数："
        
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
        ratingStart.settings.starSize = 20
        ratingStart.rating = 5
        
        return ratingStart
        
    }()
    /// 日期
    lazy var dateLab: UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kGaryFontColor
        lab.textAlignment = .right
        lab.text = "发布于11-13"
        
        return lab
    }()
}
