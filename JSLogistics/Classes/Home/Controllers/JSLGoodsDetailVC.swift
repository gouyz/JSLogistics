//
//  JSLGoodsDetailVC.swift
//  JSLogistics
//  商品详情
//  Created by gouyz on 2019/11/19.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD


private let goodsDetailMoreHeader = "goodsDetailMoreHeader"
private let goodsDetailMoreCell = "goodsDetailMoreCell"
private let goodsDetailShopCell = "goodsDetailShopCell"
private let goodsDetailRuleCell = "goodsDetailRuleCell"

class JSLGoodsDetailVC: GYZBaseVC {
    
    var dataModel: JSLGoodsDetailModel?
    /// 商品id
    var goodsId:String = ""
    /// 更多笔记
    var dataList: [JSLPublishNotesModel] = [JSLPublishNotesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarBgAlpha = 0
        automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_shared_gray")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedSharedBtn))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_back_gray")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedBackBtn))
        
        view.addSubview(buyBtn)
        buyBtn.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(kBottomTabbarHeight)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(buyBtn.snp.top)
            if #available(iOS 11.0, *) {
                make.top.equalTo(-kTitleAndStateHeight)
            }else{
                make.top.equalTo(0)
            }
        }
        tableView.tableHeaderView = headerView
        
        requestDetailInfo()
        requestNotesList()
    }
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        
        // 设置大概高度
        table.estimatedRowHeight = 360
        // 设置行高为自动适配
        table.rowHeight = UITableView.automaticDimension
        
        
        table.register(JSLNoteDetailShopCell.classForCoder(), forCellReuseIdentifier: goodsDetailShopCell)
        table.register(JSLNoteDetailMoreCell.classForCoder(), forCellReuseIdentifier: goodsDetailMoreCell)
        table.register(JSLGoodsRuleCell.classForCoder(), forCellReuseIdentifier: goodsDetailRuleCell)
        table.register(JSLNoteDetailMoreHeader.classForCoder(), forHeaderFooterViewReuseIdentifier: goodsDetailMoreHeader)
        
        return table
    }()
    
    var headerView:JSLGoodsDetailHeaderView = JSLGoodsDetailHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth + 90))
    /// 立即抢购
    lazy var buyBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("立即抢购", for: .normal)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.backgroundColor = kGreenFontColor
        btn.addTarget(self, action: #selector(onClickedBuy), for: .touchUpInside)
        
        return btn
    }()
    
    //店铺详情
    func requestDetailInfo(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("goods/goodsInfo", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? "","goods_id":goodsId],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].dictionaryObject else { return }
                weakSelf?.dataModel = JSLGoodsDetailModel.init(dict: data)
                weakSelf?.dealData()
                
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    
    func dealData(){
        if let model = dataModel {
            headerView.adsImgView.setUrlsGroup((model.goodsInfo?.imgList)!)
            headerView.nameLab.text = model.goodsInfo?.goods_name
            let priceStr = String(format:"%.2f",Float((model.goodsInfo?.shop_price)!)!)
            let marketPrice = String(format:"%.2f",Float((model.goodsInfo?.market_price)!)!)
            let str = "￥\(priceStr)"  + "  \(marketPrice)"
            let priceAtt : NSMutableAttributedString = NSMutableAttributedString(string: str)
            priceAtt.addAttribute(NSAttributedString.Key.foregroundColor, value: kRedFontColor, range: NSMakeRange(0, priceStr.count + 1))
            priceAtt.addAttribute(NSAttributedString.Key.font, value: k18Font, range: NSMakeRange(0, priceStr.count + 1))
            priceAtt.addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: NSMakeRange(str.count - marketPrice.count - 1, marketPrice.count + 1))
            priceAtt.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(str.count - marketPrice.count - 1, marketPrice.count + 1))
            
            headerView.priceLab.attributedText = priceAtt
            
            tableView.reloadData()
        }
    }
    ///获取更多笔记数据
    func requestNotesList(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("publish/getMore",parameters: ["user_id":userDefaults.string(forKey: "userId") ?? ""],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"]["publishList"].array else { return }
                for item in data{
                    guard let itemInfo = item.dictionaryObject else { return }
                    let model = JSLPublishNotesModel.init(dict: itemInfo)
                    
                    weakSelf?.dataList.append(model)
                }
                weakSelf?.tableView.reloadData()
               
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
            
        })
    }
    
    /// 分享
    @objc func clickedSharedBtn(){
        
    }
    /// 立即抢购
    @objc func onClickedBuy(){
        let vc = JSLCreateOrderVC()
        vc.goodsId = self.goodsId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 详情
    func goDetailVC(index : Int){
        let vc = JSLNoteDetailVC()
        vc.noteId = dataList[index].publish_id!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 店铺详情
    @objc func onClickedStoreDetail(){
        let vc = JSLStoreDetailVC()
        if dataModel != nil {
            vc.storeId = (self.dataModel?.storeInfo?.store_id)!
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 打电话
    @objc func onClickedCallPhone(){
        if dataModel != nil {
            GYZTool.callPhone(phone: (dataModel?.storeInfo?.store_phone)!)
        }
        
    }
}
extension JSLGoodsDetailVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: goodsDetailShopCell) as! JSLNoteDetailShopCell
            
            cell.dataModel = dataModel?.storeInfo
            cell.phoneImgView.addOnClickListener(target: self, action: #selector(onClickedCallPhone))
            
            cell.bgView.addOnClickListener(target: self, action: #selector(onClickedStoreDetail))
            
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: goodsDetailMoreCell) as! JSLNoteDetailMoreCell
            
            cell.dataModel = dataList
            cell.didSelectItemBlock = {[unowned self] (index) in
                self.goDetailVC(index: index)
            }
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: goodsDetailRuleCell) as! JSLGoodsRuleCell
            
            if dataModel != nil  {
                if indexPath.section == 1 {
                    /// lab加载富文本
                    let desStr = try? NSAttributedString.init(data: (dataModel?.goodsInfo?.goods_content)!.data(using: String.Encoding.unicode)!, options: [.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
                    cell.contentLab.attributedText = desStr
                }else{
                    cell.contentLab.text = "1.兑换时间：11:00-13:30 17:00-21:30\n2.兑换有效期：购买商品成功后，需要在3个工作日内领取抢购的商品，逾期作废。\n3.每人每周每店限购一次。\n4.该商品为活动商品，不支持退款，敬请谅解。"
                }
            }
            
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section > 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: goodsDetailMoreHeader) as! JSLNoteDetailMoreHeader
            
            if section == 1 {
                headerView.moreLab.text = "菜单"
            }else if section == 2{
                headerView.moreLab.text = "购买须知"
            }else{
                headerView.moreLab.text = "更多美食笔记"
            }
            
            return headerView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        goDetailVC()
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return kMargin
        }
        return 54
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.00001
    }
    
    //MARK:UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetY = scrollView.contentOffset.y
        let showNavBarOffsetY = kTitleAndStateHeight - topLayoutGuide.length
        
        
        //navigationBar alpha
        if contentOffsetY > showNavBarOffsetY  {
            
            var navAlpha = (contentOffsetY - (showNavBarOffsetY)) / 40.0
            if navAlpha > 1 {
                navAlpha = 1
            }
            navBarBgAlpha = navAlpha
            self.navigationItem.title = "商品详情"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_shared")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedSharedBtn))
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_back_black")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedBackBtn))
        }else{
            navBarBgAlpha = 0
            self.navigationItem.title = ""
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_shared_gray")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedSharedBtn))
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_back_gray")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedBackBtn))
        }
    }
}
