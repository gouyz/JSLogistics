//
//  JSLMyProfilePhotoCell.swift
//  JSLogistics
//  我的资料 照片cell
//  Created by gouyz on 2019/11/4.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLMyProfilePhotoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconView)
        iconView.addSubview(deleteImgView)
        deleteImgView.isHidden = true
        iconView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        deleteImgView.snp.makeConstraints({ (make) in
            make.top.equalTo(-5)
            make.right.equalTo(5)
            make.size.equalTo(CGSize.init(width: 20, height: 20))
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///
    lazy var iconView : UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kGrayBackGroundColor
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.cornerRadius = 8
        imgView.isUserInteractionEnabled = true
        
        return imgView
    }()
    lazy var deleteImgView : UIImageView = UIImageView.init(image: UIImage.init(named: "icon_group_delete"))
}
