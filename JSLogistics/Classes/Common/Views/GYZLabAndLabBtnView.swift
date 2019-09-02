//
//  GYZLabAndLabBtnView.swift
//  JSLogistics
//  2个lab上下组成btn
//  Created by gouyz on 2019/9/2.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class GYZLabAndLabBtnView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI(){
        // 添加子控件
        addSubview(desLab)
        addSubview(countLab)
        
        // 布局子控件
        countLab.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(20)
        }
        
        desLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(countLab)
            make.top.equalTo(countLab.snp.bottom)
            make.bottom.equalTo(self)
        }
    }
    
    /// 描述
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k12Font
        lab.textAlignment = .center
        
        return lab
    }()
    /// 数量
    lazy var countLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = UIFont.boldSystemFont(ofSize: 13)
        lab.textAlignment = .center
        
        return lab
    }()

}
