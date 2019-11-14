//
//  JSLNoteDetailContentFooter.swift
//  JSLogistics
//  查看全部评论
//  Created by gouyz on 2019/11/14.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLNoteDetailContentFooter: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?){
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kWhiteColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(moreLab)
        
        moreLab.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
            make.width.equalTo(kScreenWidth * 0.5)
            make.height.equalTo(34)
        }
    }
    ///
    lazy var moreLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kGreenFontColor
        lab.textAlignment = .center
        lab.text = "查看全部评论"
        
        return lab
    }()

}
