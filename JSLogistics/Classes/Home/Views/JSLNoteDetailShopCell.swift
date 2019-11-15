//
//  JSLNoteDetailShopCell.swift
//  JSLogistics
//  笔记详情 店铺cell
//  Created by gouyz on 2019/11/13.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import Cosmos

class JSLNoteDetailShopCell: UITableViewCell {
    
    /// 填充数据
    var dataModel : JSLStoreModel?{
        didSet{
            if let model = dataModel {
                
                tagImgView.kf.setImage(with: URL.init(string: model.store_logo!))
                
                nameLab.text = model.store_name
                ratingView.rating = Double.init(model.store_exponent!)!
                typeLab.text = model.store_tag
                priceLab.text = "人均￥\(model.store_consume!)"
                
                addressLab.text = model.address
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
        bgView.addSubview(ratingView)
        bgView.addSubview(typeLab)
        bgView.addSubview(priceLab)
        bgView.addSubview(rightIconView)
        contentView.addSubview(lineView)
        contentView.addSubview(addressIconView)
        contentView.addSubview(addressLab)
        contentView.addSubview(locationtagImgView)
        contentView.addSubview(lineView1)
        contentView.addSubview(phoneImgView)
        
        bgView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(80)
        }
        tagImgView.snp.makeConstraints { (make) in
            make.top.equalTo(kMargin)
            make.left.equalTo(kMargin)
            make.size.equalTo(CGSize.init(width: 60, height: 60))
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgView.snp.right).offset(kMargin)
            make.top.equalTo(tagImgView)
            make.right.equalTo(rightIconView.snp.left)
            make.height.equalTo(20)
        }
        ratingView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom)
            make.height.equalTo(20)
            make.width.equalTo(150)
        }
        typeLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.top.equalTo(ratingView.snp.bottom)
            make.height.equalTo(20)
        }
        priceLab.snp.makeConstraints { (make) in
            make.left.equalTo(typeLab.snp.right).offset(kMargin)
            make.bottom.top.equalTo(typeLab)
            make.width.equalTo(100)
        }
        rightIconView.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.centerY.equalTo(tagImgView)
            make.size.equalTo(rightArrowSize)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgView)
            make.height.equalTo(klineWidth)
            make.top.equalTo(bgView.snp.bottom)
            make.right.equalTo(-kMargin)
        }
        addressIconView.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgView)
            make.centerY.equalTo(addressLab)
            make.size.equalTo(CGSize.init(width: 13, height: 13))
        }
        addressLab.snp.makeConstraints { (make) in
            make.left.equalTo(addressIconView.snp.right).offset(kMargin)
            make.top.equalTo(lineView.snp.bottom)
            make.right.equalTo(locationtagImgView.snp.left).offset(-kMargin)
            make.height.equalTo(kTitleHeight)
            make.bottom.equalTo(-3)
        }
        phoneImgView.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.centerY.equalTo(addressLab)
            make.size.equalTo(CGSize.init(width: 15, height: 15))
        }
        lineView1.snp.makeConstraints { (make) in
            make.right.equalTo(phoneImgView.snp.left).offset(-5)
            make.top.bottom.equalTo(phoneImgView)
            make.width.equalTo(klineWidth)
        }
        locationtagImgView.snp.makeConstraints { (make) in
            make.right.equalTo(lineView1.snp.left).offset(-5)
            make.centerY.equalTo(addressLab)
            make.size.equalTo(CGSize.init(width: 12, height: 15))
        }
    }
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        
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
        lab.text = "牧马人烧烤 （南大街店）"
        
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
        ratingStart.settings.starSize = 18
        ratingStart.rating = 5
        
        return ratingStart
        
    }()
    /// 店铺类型
    lazy var typeLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kGaryFontColor
        lab.text = "面包/奶茶"
        
        return lab
    }()
    ///
    lazy var priceLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kGaryFontColor
        lab.text = "人均￥88.00"
        
        return lab
    }()
    /// 右侧箭头图标
    lazy var rightIconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_right_arrow"))
    /// 分割线
    var lineView : UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        return line
    }()
    /// 地址图标
    lazy var addressIconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_address_note_tag"))
    
    ///
    lazy var addressLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "江苏省常州市新北区"
        
        return lab
    }()
    ///定位tag图片
    lazy var locationtagImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.init(named: "icon_note_address")

        return imgView
    }()
    /// 分割线
    var lineView1 : UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        return line
    }()
    ///电话图片
    lazy var phoneImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.init(named: "icon_note_phone")

        return imgView
    }()

}
