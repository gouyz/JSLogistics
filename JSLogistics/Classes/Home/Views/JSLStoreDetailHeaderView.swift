//
//  JSLStoreDetailHeaderView.swift
//  JSLogistics
//  店铺详情 header
//  Created by gouyz on 2019/11/15.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLStoreDetailHeaderView: UIView {
    
    var didSelectItemBlock:((_ index: Int) -> Void)?
    
    
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
        self.addSubview(bgImgView)
        bgImgView.addSubview(nameLab)
        bgImgView.addSubview(desLab)
        bgImgView.addSubview(addressIconView)
        bgImgView.addSubview(addressLab)
        bgImgView.addSubview(phoneBtn)
        bgImgView.addSubview(distanceLab)
        bgImgView.addSubview(carBtn)
        
        bgImgView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(20)
            make.right.equalTo(-kMargin)
            make.height.equalTo(kTitleHeight)
        }
        desLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom)
            make.height.equalTo(30)
        }
        carBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.centerY.equalTo(distanceLab)
            make.size.equalTo(CGSize.init(width: kTitleHeight, height: kTitleHeight))
        }
        
        distanceLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.bottom.equalTo(-kMargin)
            make.right.equalTo(carBtn.snp.left).offset(-5)
            make.height.equalTo(30)
        }
        addressIconView.snp.makeConstraints { (make) in
            make.left.equalTo(distanceLab)
            make.centerY.equalTo(addressLab)
            make.size.equalTo(CGSize.init(width: 15, height: 15))
        }
        addressLab.snp.makeConstraints { (make) in
            make.left.equalTo(addressIconView.snp.right).offset(5)
            make.bottom.equalTo(distanceLab.snp.top)
            make.right.equalTo(phoneBtn.snp.left).offset(-kMargin)
            make.height.equalTo(distanceLab)
        }
        phoneBtn.snp.makeConstraints { (make) in
            make.right.size.equalTo(carBtn)
            make.centerY.equalTo(addressLab)
        }
        
    }
    ///
    lazy var bgImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kBackgroundColor
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.isUserInteractionEnabled = true
        
        return imgView
    }()
    ///名称
    lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.boldSystemFont(ofSize: 20)
        lab.textColor = kWhiteColor
        lab.text = "味千拉面"
        
        return lab
    }()
    ///类型
    lazy var desLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kWhiteColor
        lab.text = "拉面"
        
        return lab
    }()
    /// 地址图标
    lazy var addressIconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_address_tag_white"))
    
    ///
    lazy var addressLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kWhiteColor
        lab.text = "江苏省常州市新北区"
        
        return lab
    }()
    /// 电话
    lazy var phoneBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "icon_phone_white"), for: .normal)
        btn.tag = 101
        btn.addTarget(self, action: #selector(onClickedOperator(sender:)), for: .touchUpInside)
        return btn
    }()
    
    /// 距离
    lazy var distanceLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kWhiteColor
        lab.text = "距离当前1.5km"
        
        return lab
    }()
    /// 出行
    lazy var carBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "icon_car_tag_white"), for: .normal)
        btn.tag = 102
        btn.addTarget(self, action: #selector(onClickedOperator(sender:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func onClickedOperator(sender:UIButton){
        if didSelectItemBlock != nil {
            didSelectItemBlock!(sender.tag)
        }
    }
    
}
