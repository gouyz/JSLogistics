//
//  JSLSearchHotCell.swift
//  JSLogistics
//
//  Created by gouyz on 2019/11/5.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class JSLSearchHotCell: UITableViewCell {
    
    /// 填充数据
//    var dataModel : FSCoachModel?{
//        didSet{
//            if let model = dataModel {
//                
//                userImgView.kf.setImage(with: URL.init(string: model.thumb!), placeholder: UIImage.init(named: "app_img_avatar_def"))
//                nameLab.text = model.name
//                tagsView.removeAllTags()
//                tagsView.addTags(model.tags)
//                
//                tagsView.preferredMaxLayoutWidth = kScreenWidth - 145
//                
//                //必须调用,不然高度计算不准确
//                tagsView.reload()
//            }
//        }
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kWhiteColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(tagsView)
        tagsView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.bottom.equalTo(-kMargin)
        }
        
    }
    
    /// 所有标签
    lazy var tagsView: TTGTextTagCollectionView = {
        
        let view = TTGTextTagCollectionView()
        let config = view.defaultConfig
        config?.textFont = k13Font
        config?.textColor = kGaryFontColor
        config?.selectedTextColor = kGaryFontColor
        config?.borderColor = kGreenFontColor
        config?.selectedBorderColor = kGreenFontColor
        config?.backgroundColor = kWhiteColor
        config?.selectedBackgroundColor = kWhiteColor
        config?.cornerRadius = kCornerRadius
        config?.shadowOffset = CGSize.init(width: 0, height: 0)
        config?.shadowOpacity = 0
        config?.shadowRadius = 0
        config?.extraSpace = CGSize.init(width: 12, height: 8)
        view.enableTagSelection = false
        //        view.numberOfLines = 2
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.horizontalSpacing = kMargin
        view.backgroundColor = kWhiteColor
        //        view.alignment = .fillByExpandingWidth
        view.manualCalculateHeight = true
        
        return view
    }()
    
}
