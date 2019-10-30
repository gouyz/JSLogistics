//
//  JSLCartOrderDetailHeaderCell.swift
//  JSLogistics
//  购物订单详情 头xcell
//  Created by gouyz on 2019/10/30.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLCartOrderDetailHeaderCell: UITableViewCell {
    
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
        bgView.addSubview(statusNameLab)
        bgView.addSubview(desLab)
        contentView.addSubview(bgView1)
        bgView1.addSubview(tagImgView)
        bgView1.addSubview(addressLab)
        bgView1.addSubview(distanceLab)
        
        bgView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(120)
        }
        statusNameLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.bottom.equalTo(bgView.snp.centerY)
            make.right.equalTo(-kMargin)
            make.height.equalTo(30)
        }
        desLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(statusNameLab)
            make.top.equalTo(statusNameLab.snp.bottom)
            make.height.equalTo(20)
        }
        bgView1.snp.makeConstraints { (make) in
            make.left.right.equalTo(bgView)
            make.top.equalTo(bgView.snp.bottom)
            make.height.equalTo(70)
            make.bottom.equalTo(contentView)
        }
        tagImgView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.centerY.equalTo(bgView1)
            make.size.equalTo(CGSize.init(width: 32, height: 32))
        }
        addressLab.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgView.snp.right).offset(kMargin)
            make.top.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.height.equalTo(30)
        }
        distanceLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(addressLab)
            make.top.equalTo(addressLab.snp.bottom)
            make.height.equalTo(20)
        }
        
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = kGreenFontColor
        
        return view
    }()
    /// 订单状态
    lazy var statusNameLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kWhiteColor
        lab.font = k18Font
        lab.text = "待使用"
        
        return lab
    }()
    ///
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kWhiteColor
        lab.font = k15Font
        lab.text = "期待您早日到店使用"
        
        return lab
    }()
    lazy var bgView1: UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        
        return view
    }()
    /// 地址图片
    lazy var tagImgView : UIImageView = UIImageView.init(image: UIImage.init(named: "icon_tag_address_shop"))
    
    /// 地址
    lazy var addressLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k15Font
        lab.text = "江苏省常州市南大街"
        
        return lab
    }()
    /// 距离
    lazy var distanceLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGaryFontColor
        lab.font = k13Font
        lab.text = "距当前2KM"
        
        return lab
    }()
    
}
