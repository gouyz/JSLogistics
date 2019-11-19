//
//  JSLGoodsRuleCell.swift
//  JSLogistics
//  商品详情 购买须知、菜单cell
//  Created by gouyz on 2019/11/19.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLGoodsRuleCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kWhiteColor
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(contentLab)
        
        contentLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(kMargin)
            make.bottom.equalTo(-kMargin)
        }
    }
    /// 内容
    lazy var contentLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k13Font
        lab.numberOfLines = 0
        lab.text = "很有效很有效很有效很有效很有效很有效很有效很有效很有效很有效......"
        
        return lab
    }()

}
