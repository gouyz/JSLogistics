//
//  JSLUploadPhotoCell.swift
//  JSLogistics
//
//  Created by gouyz on 2019/11/4.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

private let uploadPhotoCell = "uploadPhotoCell"

class JSLUploadPhotoCell: UITableViewCell {
    
    let itemWidth = floor((kScreenWidth - kMargin * 5)/4)
    
    var didSelectItemBlock:((_ index: Int) -> Void)?
    var didDeleteItemBlock:((_ index: Int) -> Void)?
    
    /// 填充数据
    var dataModel : [JSLMyProfilePhotoModel]?{
        didSet{
            if dataModel != nil {
                
                self.collectionView.reloadData()
                self.collectionView.layoutIfNeeded()
                let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
                
                self.collectionView.snp.updateConstraints { (make) in
                    make.height.equalTo(height)
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.backgroundColor = kWhiteColor
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.bottom.equalTo(-kMargin)
            make.height.equalTo(itemWidth)
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets.init(top: kMargin, left: kMargin, bottom: kMargin, right: kMargin)
        layout.itemSize = CGSize.init(width: itemWidth, height: itemWidth)
        
        let collView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collView.dataSource = self
        collView.delegate = self
        collView.alwaysBounceHorizontal = false
        collView.backgroundColor = kWhiteColor
        collView.isScrollEnabled = false
        
        collView.register(JSLMyProfilePhotoCell.classForCoder(), forCellWithReuseIdentifier: uploadPhotoCell)
        
        return collView
    }()
    /// 删除
    @objc func onClickedDelete(sender:UITapGestureRecognizer){
        if didDeleteItemBlock != nil {
            didDeleteItemBlock!((sender.view?.tag)!)
        }
    }
}

extension JSLUploadPhotoCell : UICollectionViewDataSource,UICollectionViewDelegate{
    
    // MARK: UICollectionViewDataSource 代理方法
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataModel != nil {
            return dataModel!.count + 1
        }
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: uploadPhotoCell, for: indexPath) as! JSLMyProfilePhotoCell
        
        cell.deleteImgView.tag = indexPath.row
        cell.deleteImgView.addOnClickListener(target: self, action: #selector(onClickedDelete(sender:)))
        cell.deleteImgView.isHidden = false
        if dataModel == nil || dataModel?.count == indexPath.row {
            cell.deleteImgView.isHidden = true
            cell.iconView.image = UIImage.init(named: "icon_upload_img")
        }else{
            cell.deleteImgView.isHidden = false
            let model = dataModel![indexPath.row]
            if model.isUrl == "1" {
                cell.iconView.kf.setImage(with: URL.init(string: model.imgURL!))
            }else{
                cell.iconView.image = model.img
            }
        }
        
        return cell
    }
    // MARK: UICollectionViewDelegate的代理方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didSelectItemBlock != nil {
            didSelectItemBlock!(indexPath.row)
        }
    }
    
}

