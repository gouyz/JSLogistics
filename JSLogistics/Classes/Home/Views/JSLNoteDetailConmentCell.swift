//
//  JSLNoteDetailConmentCell.swift
//  JSLogistics
//  笔记详情 评论cell
//  Created by gouyz on 2019/11/13.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLNoteDetailConmentCell: UITableViewCell {
    
    /// 填充数据
    var dataModel : JSLConmentModel?{
        didSet{
            if let model = dataModel {
                
                nameLab.text = model.username
                contentLab.text = model.content
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kWhiteColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(nameLab)
        contentView.addSubview(contentLab)
        
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.centerY.equalTo(contentLab)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        contentLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab.snp.right).offset(kMargin)
            make.top.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.bottom.equalTo(-kMargin)
        }
       
    }
    ///名称
    lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "陪你度过夏天："
        
        return lab
    }()
    /// 内容
    lazy var contentLab: UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kGaryFontColor
        lab.numberOfLines = 0
        lab.text = "真的很好，不错"
        
        return lab
    }()
}
