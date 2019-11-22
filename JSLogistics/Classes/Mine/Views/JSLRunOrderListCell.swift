//
//  JSLRunOrderListCell.swift
//  JSLogistics
//  出行订单cell
//  Created by gouyz on 2019/10/30.
//  Copyright © 2019 gouyz. All rights reserved.
//  3847 855 1811 412 561

import UIKit

class JSLRunOrderListCell: UITableViewCell {
    
    /// 填充数据
    var dataModel : JSLTripOrderModel?{
        didSet{
            if let model = dataModel {
                statusNameLab.text = model.status_name
                dateLab.text = model.time
                addressLab.text = model.departure
                toAddressLab.text = model.destination
                ///order_status:0：待出行；1：待评价；2：已完成；3：已取消
                let status: String = model.status!
                
                if status == "1" {
                    cancleBtn.isHidden = true
                    cancleBtn.snp.updateConstraints { (make) in
                        make.height.equalTo(0)
                    }
                    operatorBtn.isHidden = false
                    operatorBtn.setTitle("立即评价", for: .normal)
                    operatorBtn.snp.updateConstraints { (make) in
                        make.width.equalTo(80)
                        make.height.equalTo(30)
                    }
                }else {
                    cancleBtn.isHidden = true
                    cancleBtn.snp.updateConstraints { (make) in
                        make.height.equalTo(0)
                    }
                    operatorBtn.isHidden = true
                    operatorBtn.snp.updateConstraints { (make) in
                        make.width.equalTo(0)
                        make.height.equalTo(0)
                    }
                }
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
        bgView.addSubview(tagIconView)
        bgView.addSubview(nameLab)
        bgView.addSubview(statusNameLab)
        bgView.addSubview(dateLab)
        bgView.addSubview(dateTagView)
        bgView.addSubview(addressLab)
        bgView.addSubview(addressTagView)
        bgView.addSubview(toAddressTagView)
        bgView.addSubview(toAddressLab)
        bgView.addSubview(operatorBtn)
        bgView.addSubview(cancleBtn)
        
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.bottom.equalTo(contentView)
        }
        tagIconView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.centerY.equalTo(nameLab)
            
            make.size.equalTo(CGSize.init(width: 18, height: 16))
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(tagIconView.snp.right).offset(5)
            make.top.equalTo(bgView)
            make.height.equalTo(kTitleHeight)
            make.right.equalTo(statusNameLab.snp.left).offset(-kMargin)
        }
        statusNameLab.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.top.height.equalTo(nameLab)
            make.width.equalTo(80)
        }
        dateTagView.snp.makeConstraints { (make) in
            make.left.equalTo(tagIconView)
            make.centerY.equalTo(dateLab)
            make.size.equalTo(CGSize.init(width: 8, height: 8))
        }
        dateLab.snp.makeConstraints { (make) in
            make.left.equalTo(dateTagView.snp.right).offset(kMargin)
            make.top.equalTo(nameLab.snp.bottom).offset(5)
            make.right.equalTo(-kMargin)
            make.height.equalTo(30)
        }
        addressTagView.snp.makeConstraints { (make) in
            make.left.size.equalTo(dateTagView)
            make.centerY.equalTo(addressLab)
        }
        addressLab.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(dateLab)
            make.top.equalTo(dateLab.snp.bottom)
        }
        toAddressTagView.snp.makeConstraints { (make) in
            make.left.size.equalTo(dateTagView)
            make.centerY.equalTo(toAddressLab)
        }
        toAddressLab.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(dateLab)
            make.top.equalTo(addressLab.snp.bottom)
        }
        operatorBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.top.equalTo(toAddressLab.snp.bottom).offset(kMargin)
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.bottom.equalTo(-kMargin)
        }
        cancleBtn.snp.makeConstraints { (make) in
            make.right.equalTo(operatorBtn.snp.left).offset(-15)
            make.top.equalTo(operatorBtn)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        view.cornerRadius = kCornerRadius
        
        return view
    }()
    /// 图标
    lazy var tagIconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_car_tag_default"))
    ///
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGaryFontColor
        lab.font = k15Font
        lab.text = "即时出行"
        
        return lab
    }()
    /// 订单状态
    lazy var statusNameLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGreenFontColor
        lab.font = k13Font
        lab.textAlignment = .right
        lab.text = "待出行"
        
        return lab
    }()
    ///
    lazy var dateTagView: UIView = {
        let view = UIView()
        view.backgroundColor = kZiSeFontColor
        view.cornerRadius = 4
        
        return view
    }()
    /// 日期
    lazy var dateLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGaryFontColor
        lab.font = k13Font
        lab.text = "2019年06月08日 14:20"
        
        return lab
    }()
    ///
    lazy var addressTagView: UIView = {
        let view = UIView()
        view.backgroundColor = kGreenFontColor
        view.cornerRadius = 4
        
        return view
    }()
    /// 地址
    lazy var addressLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGaryFontColor
        lab.font = k13Font
        lab.text = "南大街店"
        
        return lab
    }()
    ///
    lazy var toAddressTagView: UIView = {
        let view = UIView()
        view.backgroundColor = kOrangeFontColor
        view.cornerRadius = 4
        
        return view
    }()
    /// 地址
    lazy var toAddressLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGaryFontColor
        lab.font = k13Font
        lab.text = "新北万达鱼你在一起"
        
        return lab
    }()
    /// 取消
    lazy var cancleBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k13Font
        btn.setTitleColor(kGaryFontColor, for: .normal)
        btn.backgroundColor = kWhiteColor
        btn.setTitle("取消订单", for: .normal)
        btn.cornerRadius = 15
        btn.borderColor = kGaryFontColor
        btn.borderWidth = klineWidth
        return btn
    }()
    
    /// 操作
    lazy var operatorBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k13Font
        btn.setTitleColor(kGreenFontColor, for: .normal)
        btn.backgroundColor = kWhiteColor
        btn.setTitle("催一催", for: .normal)
        btn.cornerRadius = 15
        btn.borderColor = kGreenFontColor
        btn.borderWidth = klineWidth
        return btn
    }()
    
}
