//
//  JSLNoteDetailMoreHeader.swift
//  JSLogistics
//  笔记详情 更多美食笔记
//  Created by gouyz on 2019/11/14.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLNoteDetailMoreHeader: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?){
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kBackgroundColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(bgView)
        bgView.addSubview(moreLab)
        bgView.addSubview(lineView)
        
        bgView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(kMargin)
        }
        moreLab.snp.makeConstraints { (make) in
            make.center.equalTo(bgView)
            make.height.equalTo(30)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(moreLab)
            make.top.equalTo(moreLab.snp.bottom)
            make.height.equalTo(klineWidth)
        }
    }
    lazy var bgView:UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        view.isUserInteractionEnabled = true
        
        return view
    }()
    ///
    lazy var moreLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.textAlignment = .center
        lab.text = "更多美食笔记"
        
        return lab
    }()
    /// 分割线
    var lineView : UIView = {
        let line = UIView()
        line.backgroundColor = kGreenFontColor
        return line
    }()
}
