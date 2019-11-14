//
//  JSLNoteDetailMoreCell.swift
//  JSLogistics
//  笔记详情 更多美食cell
//  Created by gouyz on 2019/11/14.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

private let noteDetailMoreChildCell = "noteDetailMoreChildCell"

class JSLNoteDetailMoreCell: UITableViewCell {
    
    let itemWidth = floor((kScreenWidth - kMargin * 3)/2)
    
    var didSelectItemBlock:((_ index: Int) -> Void)?
    
    /// 填充数据
    var dataModel : [JSLPublishNotesModel]?{
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
            make.height.equalTo(itemWidth * 1.34 + 80 + kTitleHeight)
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        
        layout.sectionInset = UIEdgeInsets.init(top: kMargin, left: kMargin, bottom: kMargin, right: kMargin)
        
        let collView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collView.dataSource = self
        collView.delegate = self
        collView.alwaysBounceHorizontal = false
        collView.backgroundColor = kBackgroundColor
        collView.isScrollEnabled = false
        
        collView.register(JSLHomeShopCell.classForCoder(), forCellWithReuseIdentifier: noteDetailMoreChildCell)
        
        return collView
    }()
}

extension JSLNoteDetailMoreCell : UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout{
    
    // MARK: UICollectionViewDataSource 代理方法
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel != nil ? dataModel!.count : 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: noteDetailMoreChildCell, for: indexPath) as! JSLHomeShopCell
        
        cell.dataModel = dataModel?[indexPath.row]
        
        return cell
    }
    // MARK: UICollectionViewDelegate的代理方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didSelectItemBlock != nil {
            didSelectItemBlock!(indexPath.row)
        }
    }
    //MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
    
    //** Size for the cells in the Waterfall Layout */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        var height: CGFloat = itemWidth * 0.75
        if indexPath.row == 0 {
            height = itemWidth * 1.34
        }
        
        return CGSize(width: itemWidth, height: height + 80 + kTitleHeight)
    }
    
}
