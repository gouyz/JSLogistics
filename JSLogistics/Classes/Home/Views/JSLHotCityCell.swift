//
//  JSLHotCityCell.swift
//  JSLogistics
//  热门城市 cell
//  Created by gouyz on 2019/11/25.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLHotCityCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = kWhiteColor
        addSubview(imgView)
        
        imgView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var imgView: UIImageView = {
       let img = UIImageView()
        img.backgroundColor = kBackgroundColor
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        
        return img
    }()
}
