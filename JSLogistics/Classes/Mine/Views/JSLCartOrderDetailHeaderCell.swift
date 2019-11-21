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
        
        bgView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(120)
            make.bottom.equalTo(contentView)
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
    
}
