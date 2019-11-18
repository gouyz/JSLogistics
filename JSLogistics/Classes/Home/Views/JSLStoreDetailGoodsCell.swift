//
//  JSLStoreDetailGoodsCell.swift
//  JSLogistics
//  店铺详情 商品cell
//  Created by gouyz on 2019/11/15.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLStoreDetailGoodsCell: UITableViewCell {
    
    /// 填充数据
    var dataModel : JSLGoodsModel?{
        didSet{
            if let model = dataModel {
                
                tagImgView.kf.setImage(with: URL.init(string: model.original_img!))
                
                nameLab.text = model.goods_name
                
                let priceStr = String(format:"%.2f",Float((model.shop_price)!)!)
                let marketPrice = String(format:"%.2f",Float((model.market_price)!)!)
                let str = "￥\(priceStr)"  + "  \(marketPrice)"
                let priceAtt : NSMutableAttributedString = NSMutableAttributedString(string: str)
                priceAtt.addAttribute(NSAttributedString.Key.foregroundColor, value: kRedFontColor, range: NSMakeRange(0, priceStr.count + 1))
                priceAtt.addAttribute(NSAttributedString.Key.font, value: k18Font, range: NSMakeRange(0, priceStr.count + 1))
                priceAtt.addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: NSMakeRange(str.count - marketPrice.count - 1, marketPrice.count + 1))
                priceAtt.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(str.count - marketPrice.count - 1, marketPrice.count + 1))
                
                priceLab.attributedText = priceAtt
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
        contentView.addSubview(bgView)
        bgView.addSubview(tagImgView)
        bgView.addSubview(nameLab)
        bgView.addSubview(priceLab)
        bgView.addSubview(operatorBtn)
        
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(kMargin)
            make.height.equalTo(90)
            make.bottom.equalTo(-5)
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
    }
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        view.cornerRadius = kCornerRadius
        view.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 4
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
}
