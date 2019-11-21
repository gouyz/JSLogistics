//
//  JSLCartOrderListCell.swift
//  JSLogistics
//  购物订单 cell
//  Created by gouyz on 2019/10/29.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLCartOrderListCell: UITableViewCell {
    
    /// 填充数据
    var dataModel : JSLGoodsOrderModel?{
        didSet{
            if let model = dataModel {
                shopNameLab.text = model.storeInfo?.store_name
                statusNameLab.text = model.status_name
                foodImgView.kf.setImage(with: URL.init(string: (model.goodsInfo?.original_img)!))
                nameLab.text = model.goodsInfo?.goods_name
                
                priceLab.text = "￥\((model.goodsInfo?.goods_price)!)"
                ///order_status:0：取消订单，立即支付；1:立即使用；2：立即评价；
                let status: String = model.order_status!
                
                if status == "0" {
                    cancleBtn.isHidden = false
                    cancleBtn.snp.updateConstraints { (make) in
                        make.height.equalTo(30)
                    }
                    operatorBtn.isHidden = false
                    operatorBtn.setTitle("立即支付", for: .normal)
                    operatorBtn.snp.updateConstraints { (make) in
                        make.width.equalTo(80)
                        make.height.equalTo(30)
                    }
                }else if status == "1" {
                    cancleBtn.isHidden = true
                    cancleBtn.snp.updateConstraints { (make) in
                        make.height.equalTo(0)
                    }
                    operatorBtn.isHidden = false
                    operatorBtn.setTitle("立即使用", for: .normal)
                    operatorBtn.snp.updateConstraints { (make) in
                        make.width.equalTo(80)
                        make.height.equalTo(30)
                    }
                }else if status == "2" {
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
        bgView.addSubview(shopNameLab)
        bgView.addSubview(rightIconView)
        bgView.addSubview(statusNameLab)
        bgView.addSubview(foodImgView)
        bgView.addSubview(nameLab)
        bgView.addSubview(priceLab)
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
            make.centerY.equalTo(shopNameLab)
           
            make.size.equalTo(CGSize.init(width: 20, height: 16))
        }
        shopNameLab.snp.makeConstraints { (make) in
            make.left.equalTo(tagIconView.snp.right).offset(5)
            make.top.equalTo(bgView)
            make.height.equalTo(kTitleHeight)
        }
        rightIconView.snp.makeConstraints { (make) in
            make.left.equalTo(shopNameLab.snp.right).offset(kMargin)
            make.centerY.equalTo(shopNameLab)
            make.size.equalTo(rightArrowSize)
        }
        statusNameLab.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.top.height.equalTo(shopNameLab)
            make.width.equalTo(80)
        }
        foodImgView.snp.makeConstraints { (make) in
            make.left.equalTo(tagIconView)
            make.top.equalTo(shopNameLab.snp.bottom).offset(5)
            make.size.equalTo(CGSize.init(width: 90, height: 90))
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(foodImgView.snp.right).offset(kMargin)
            make.top.equalTo(foodImgView)
            make.right.equalTo(-kMargin)
        }
        priceLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLab)
            make.height.equalTo(20)
            make.bottom.equalTo(foodImgView)
        }
        operatorBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.top.equalTo(foodImgView.snp.bottom).offset(kMargin)
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
        view.isUserInteractionEnabled = true
        
        return view
    }()
    /// 图标
    lazy var tagIconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_seller_tag_default"))
    /// 店铺名称
    lazy var shopNameLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGaryFontColor
        lab.font = k15Font
        lab.text = "心语随旗舰店"
        
        return lab
    }()
    /// 右侧箭头图标
    lazy var rightIconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_right_arrow"))
    /// 订单状态
    lazy var statusNameLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGreenFontColor
        lab.font = k13Font
        lab.textAlignment = .right
        lab.text = "待使用"
        
        return lab
    }()
    /// 食物图片
    lazy var foodImgView : UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kBackgroundColor
        imgView.cornerRadius = 5
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        
        return imgView
    }()
    /// 名称
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k15Font
        lab.numberOfLines = 2
        lab.text = "用心熬好粥，用心熬好粥，用心熬好粥"
        
        return lab
    }()
    /// 金额
    lazy var priceLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kRedFontColor
        lab.font = k15Font
        lab.text = "￥88.00"
        
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
        btn.setTitle("立即使用", for: .normal)
        btn.cornerRadius = 15
        btn.borderColor = kGreenFontColor
        btn.borderWidth = klineWidth
        return btn
    }()

}
