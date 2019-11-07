//
//  JSLShopListCell.swift
//  JSLogistics
//  探店 cell
//  Created by gouyz on 2019/8/9.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLShopListCell: UITableViewCell {
    
    /// 填充数据
    var dataModel : JSLGoodsModel?{
        didSet{
            if let model = dataModel {
                
                tagImgView.kf.setImage(with: URL.init(string: model.original_img!), placeholder: UIImage.init(named: ""))
                
                let priceStr = String(format:"%.2f",Float((model.shop_price)!)!)
                let marketPrice = String(format:"%.2f",Float((model.market_price)!)!)
                let str = "￥\(priceStr)"  + "  \(marketPrice)"
                let priceAtt : NSMutableAttributedString = NSMutableAttributedString(string: str)
                priceAtt.addAttribute(NSAttributedString.Key.foregroundColor, value: kRedFontColor, range: NSMakeRange(0, priceStr.count + 1))
                priceAtt.addAttribute(NSAttributedString.Key.font, value: k18Font, range: NSMakeRange(0, priceStr.count + 1))
                priceAtt.addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: NSMakeRange(str.count - marketPrice.count - 1, marketPrice.count + 1))
                priceAtt.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(str.count - marketPrice.count - 1, marketPrice.count + 1))
                
                priceLab.attributedText = priceAtt
                
                nameLab.text = model.goods_name
                desLab.text = model.address
                distanceLab.text = model.distance
                
                operatorBtn.isHidden = true
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kBackgroundColor
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(bgView)
        bgView.addSubview(tagImgView)
        bgView.addSubview(nameLab)
        bgView.addSubview(desLab)
        bgView.addSubview(distanceLab)
        bgView.addSubview(priceLab)
        bgView.addSubview(operatorBtn)
        
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(kMargin)
            make.left.right.bottom.equalTo(contentView)
        }
        tagImgView.snp.makeConstraints { (make) in
            make.top.equalTo(kMargin)
            make.left.equalTo(kMargin)
            make.width.equalTo(140)
            make.bottom.equalTo(-kMargin)
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgView.snp.right).offset(kMargin)
            make.top.equalTo(tagImgView)
            make.right.equalTo(-kMargin)
        }
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.right.equalTo(distanceLab.snp.left).offset(-kMargin)
            make.top.equalTo(nameLab.snp.bottom).offset(kMargin)
            make.height.equalTo(20)
        }
        distanceLab.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(desLab)
            make.right.equalTo(-kMargin)
            make.width.equalTo(80)
        }
        priceLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(tagImgView)
            make.left.equalTo(nameLab)
            make.right.equalTo(operatorBtn.snp.left).offset(-kMargin)
            make.height.equalTo(24)
        }
        operatorBtn.snp.makeConstraints { (make) in
            make.right.equalTo(distanceLab)
            make.bottom.equalTo(priceLab)
            make.size.equalTo(CGSize.init(width: 60, height: 34))
        }
    }
    ///背景view
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        
        return view
    }()
    /// 图片
    lazy var tagImgView : UIImageView = {
        let img = UIImageView()
        img.cornerRadius = kCornerRadius
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.backgroundColor = kBackgroundColor
        
        return img
    }()
    /// cell title
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.numberOfLines = 0
        lab.text = "超级好吃的美味烧烤 牧马人双人餐 牧马人双人餐"
        
        return lab
    }()
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kHeightGaryFontColor
        lab.text = "牧马人烧烤 （南大街店）"
        
        return lab
    }()
    lazy var distanceLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kHeightGaryFontColor
        lab.textAlignment = .right
        lab.text = "3.5km"
        
        return lab
    }()
    /// 原价
    lazy var priceLab : UILabel = {
        let lab = UILabel()
        lab.font = k12Font
        lab.textColor = kHeightGaryFontColor
        
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
        
        return btn
    }()
}
