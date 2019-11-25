//
//  JSLSelectCityHeaderView.swift
//  JSLogistics
//  选择城市 header
//  Created by gouyz on 2019/11/25.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLSelectCityHeaderView: UICollectionReusableView {
    
    // MARK: 生命周期方法
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = kBackgroundColor
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(nameLab)
        
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.bottom.equalTo(self)
            make.right.equalTo(-kMargin)
        }
        
    }
    ///
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k15Font
        
        return lab
    }()
}
