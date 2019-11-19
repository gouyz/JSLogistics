//
//  JSLCreateOrderVC.swift
//  JSLogistics
//  支付详情
//  Created by gouyz on 2019/11/19.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD

class JSLCreateOrderVC: GYZBaseVC {
    /// 商品id
    var goodsId:String = ""
    
    var dataModel: JSLCreateOrderModel?
    /// 1：代表支付宝支付；2：代表微信支付
    var payType: String = "1"
    /// 是否使用虚拟货币：1：否；2：是
    var isUserXuni:String = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "支付详情"
        self.view.backgroundColor = kWhiteColor
        
        setUpUI()
        
        payView.selectPayTypeBlock = {[unowned self] (isAliPay) in
            if isAliPay {
                self.payType = "1"
            }else{
                self.payType = "2"
            }
        }
        payView.openXuniPayBlock = {[unowned self] () in
            let money: Double = Double.init((self.dataModel?.user_money)!)!
            if money > 0 {
                self.payView.xuniCheckBtn.isSelected = !self.payView.xuniCheckBtn.isSelected
                if self.payView.xuniCheckBtn.isSelected {
                    self.isUserXuni = "2"
                }else{
                    self.isUserXuni = "1"
                }
            }else{
                MBProgressHUD.showAutoDismissHUD(message: "虚拟币为0")
            }
        }
        
        requestOrderInfo()
    }
    
    
    func setUpUI(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(tagImgView)
        contentView.addSubview(shopNameLab)
        contentView.addSubview(foodImgView)
        contentView.addSubview(nameLab)
        contentView.addSubview(addressLab)
        contentView.addSubview(priceLab)
        contentView.addSubview(lineView)
        contentView.addSubview(payView)
        contentView.addSubview(lineView1)
        contentView.addSubview(buyDesLab)
        contentView.addSubview(lineView2)
        contentView.addSubview(contentLab)
        
        view.addSubview(buyBtn)
        
        scrollView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.bottom.equalTo(buyBtn.snp.top)
        }
        buyBtn.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(kBottomTabbarHeight)
        }
        contentView.snp.makeConstraints { (make) in
            make.left.width.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            // 这个很重要！！！！！！
            // 必须要比scroll的高度大一，这样才能在scroll没有填充满的时候，保持可以拖动
            make.height.greaterThanOrEqualTo(scrollView).offset(1)
        }
        shopNameLab.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgView.snp.right).offset(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(contentView)
            make.height.equalTo(kTitleHeight)
        }
        tagImgView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.centerY.equalTo(shopNameLab)
            make.size.equalTo(CGSize.init(width: 16, height: 16))
        }
        foodImgView.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgView)
            make.top.equalTo(shopNameLab.snp.bottom).offset(5)
            make.size.equalTo(CGSize.init(width: 90, height: 90))
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(foodImgView.snp.right).offset(kMargin)
            make.top.equalTo(foodImgView).offset(kMargin)
            make.right.equalTo(-kMargin)
        }
        addressLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.right.equalTo(-kMargin)
            make.top.equalTo(nameLab.snp.bottom).offset(kMargin)
            make.height.equalTo(20)
        }
        priceLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(addressLab)
            make.top.equalTo(addressLab.snp.bottom)
            make.bottom.equalTo(foodImgView)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(foodImgView.snp.bottom).offset(kMargin)
            make.height.equalTo(kMargin)
        }
        payView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(lineView.snp.bottom)
            make.height.equalTo(200)
        }
        lineView1.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.top.equalTo(payView.snp.bottom)
        }
        buyDesLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.height.equalTo(30)
            make.top.equalTo(lineView1.snp.bottom).offset(kMargin)
        }
        lineView2.snp.makeConstraints { (make) in
            make.left.right.equalTo(buyDesLab)
            make.top.equalTo(buyDesLab.snp.bottom)
            make.height.equalTo(klineWidth)
        }
        contentLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(lineView2.snp.bottom).offset(kMargin)
            // 这个很重要，viewContainer中的最后一个控件一定要约束到bottom，并且要小于等于viewContainer的bottom
            // 否则的话，上面的控件会被强制拉伸变形
            // 最后的-10是边距，这个可以随意设置
            make.bottom.lessThanOrEqualTo(contentView).offset(-kMargin)
        }
        
    }
    /// scrollView
    var scrollView: UIScrollView = UIScrollView()
    /// 内容View
    var contentView: UIView = UIView()
    
    lazy var tagImgView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_seller_tag_default"))
    ///
    lazy var shopNameLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "店铺名称"
        
        return lab
    }()
    /// 食物图片
    lazy var foodImgView : UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kBackgroundColor
        imgView.cornerRadius = 5
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        
        return imgView
    }()
    /// 名称
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k15Font
        lab.numberOfLines = 2
        lab.text = "用心熬好粥，用心熬好粥，用心熬好粥"
        
        return lab
    }()
    /// 地址
    lazy var addressLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kGaryFontColor
        lab.font = k12Font
        lab.text = "南大街店"
        
        return lab
    }()
    /// 金额
    lazy var priceLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kRedFontColor
        lab.font = k15Font
        lab.text = "￥88.00"
        
        return lab
    }()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = kBackgroundColor
        
        return view
    }()
    
    /// 支付方式View
    lazy var payView: LHSSelectPayMethodView = LHSSelectPayMethodView()
    
    lazy var lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = kBackgroundColor
        
        return view
    }()
    ///
    lazy var buyDesLab: UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.textAlignment = .center
        lab.text = "购买须知"
        
        return lab
    }()
    /// 分割线
    var lineView2 : UIView = {
        let line = UIView()
        line.backgroundColor = kGreenFontColor
        return line
    }()
    /// 内容
    lazy var contentLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k15Font
        lab.numberOfLines = 0
        lab.text = "1.兑换时间：11:00-13:30 17:00-21:30\n2.兑换有效期：购买商品成功后，需要在3个工作日内领取抢购的商品，逾期作废。\n3.每人每周每店限购一次。\n4.该商品为活动商品，不支持退款，敬请谅解。"
        
        return lab
    }()
    
    /// 确认支付
    lazy var buyBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("确认支付", for: .normal)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.backgroundColor = kGreenFontColor
        btn.addTarget(self, action: #selector(onClickedBuy), for: .touchUpInside)
        
        return btn
    }()
    
    //获取订单页面数据
    func requestOrderInfo(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("cart/cart", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? "","goods_id":goodsId],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
        
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].dictionaryObject else { return }
                weakSelf?.dataModel = JSLCreateOrderModel.init(dict: data)
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
            shopNameLab.text = model.storeInfo?.store_name
            foodImgView.kf.setImage(with: URL.init(string: (model.goodsInfo?.original_img)!))
            nameLab.text = model.goodsInfo?.goods_name
            addressLab.text = model.goodsInfo?.address
            
            let priceStr = String(format:"%.2f",Float((model.goodsInfo?.shop_price)!)!)
            let marketPrice = String(format:"%.2f",Float((model.goodsInfo?.market_price)!)!)
            let str = "￥\(priceStr)"  + "  \(marketPrice)"
            let priceAtt : NSMutableAttributedString = NSMutableAttributedString(string: str)
            priceAtt.addAttribute(NSAttributedString.Key.foregroundColor, value: kRedFontColor, range: NSMakeRange(0, priceStr.count + 1))
            priceAtt.addAttribute(NSAttributedString.Key.font, value: k18Font, range: NSMakeRange(0, priceStr.count + 1))
            priceAtt.addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: NSMakeRange(str.count - marketPrice.count - 1, marketPrice.count + 1))
            priceAtt.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(str.count - marketPrice.count - 1, marketPrice.count + 1))
            
            priceLab.attributedText = priceAtt
            
            payView.xuniNameLab.text = "虚拟币抵扣￥\((model.user_money)!)"
            buyBtn.setTitle("确认支付￥\((model.goodsInfo?.shop_price)!)", for: .normal)
        }
    }
    /// 确认支付
    @objc func onClickedBuy(){
        requestSubmitOrderInfo()
    }
    
    //提交订单页面数据
    func requestSubmitOrderInfo(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("cart/cart2", parameters: ["user_id":userDefaults.string(forKey: "userId") ?? "","goods_id":goodsId,"type":payType,"is_user":isUserXuni],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
        
            MBProgressHUD.showAutoDismissHUD(message: "下单成功")
//            MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
//            if response["status"].intValue == kQuestSuccessTag{//请求成功
//
//            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
}
