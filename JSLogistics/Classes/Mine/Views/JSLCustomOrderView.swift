//
//  JSLCustomOrderView.swift
//  JSLogistics
//  订单选择 view
//  Created by gouyz on 2019/10/28.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLCustomOrderView: UIView {
    
    
    ///点击事件闭包
    var action:((_ alertView: JSLCustomOrderView,_ index: Int) -> Void)?

    // MARK: 生命周期方法
    override init(frame:CGRect){
        super.init(frame:frame)
    }
    convenience init(){
        let rect = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.init(frame: rect)
        
        self.backgroundColor = UIColor.clear
        
        backgroundView.frame = rect
        backgroundView.alpha = 0
        backgroundView.backgroundColor = kBlackColor
        addSubview(backgroundView)
        backgroundView.addOnClickListener(target: self, action: #selector(onTapCancle(sender:)))
        
        setupUI()
        
        cartOrderBtn.set(image: UIImage.init(named: "icon_gouwu_order"), title: "购物订单", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        chuxingOrderBtn.set(image: UIImage.init(named: "icon_chuxing_order"), title: "出行订单", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        
        addSubview(bgView)
        bgView.addOnClickListener(target: self, action: #selector(onBlankClicked))
        
        bgView.addSubview(cartOrderBtn)
        bgView.addSubview(chuxingOrderBtn)
        
        bgView.frame = CGRect.init(x: 0, y: frame.size.height, width: kScreenWidth, height: 180)
        
        cartOrderBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView)
            make.left.equalTo(20)
            make.height.equalTo(100)
            make.width.equalTo(chuxingOrderBtn)
        }
        chuxingOrderBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.left.equalTo(cartOrderBtn.snp.right).offset(30)
            make.width.height.centerY.equalTo(cartOrderBtn)
        }
    }
    
    ///整体背景
    var backgroundView: UIView = UIView()
    /// 透明背景
    var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        view.cornerRadius  = kCornerRadius
        
        return view
    }()

    
    
    /// 购物订单
    lazy var cartOrderBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        btn.tag = 101
        btn.addTarget(self, action: #selector(clickedOperatorBtn(sender:)), for: .touchUpInside)
        
        return btn
    }()
    /// 出行订单
    lazy var chuxingOrderBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        btn.tag = 102
        btn.addTarget(self, action: #selector(clickedOperatorBtn(sender:)), for: .touchUpInside)
        
        return btn
    }()
    /// 显示
    func show(){
        UIApplication.shared.keyWindow?.addSubview(self)
        
        addAnimation()
    }
    
    ///添加显示动画
    func addAnimation(){
        
        weak var weakSelf = self
        UIView.animate(withDuration: 0.5, animations: {
            
            weakSelf?.bgView.frame = CGRect.init(x: (weakSelf?.bgView.frame.origin.x)!, y: (weakSelf?.frame.size.height)! - (weakSelf?.bgView.frame.size.height)!, width: (weakSelf?.bgView.frame.size.width)!, height: (weakSelf?.bgView.frame.size.height)!)
            
            //            weakSelf?.bgView.center = (weakSelf?.center)!
            weakSelf?.backgroundView.alpha = 0.2
            
        }) { (finished) in
            
        }
    }
    
    ///移除动画
    func removeAnimation(){
        weak var weakSelf = self
        UIView.animate(withDuration: 0.5, animations: {
            
            weakSelf?.bgView.frame = CGRect.init(x: (weakSelf?.bgView.frame.origin.x)!, y: (weakSelf?.frame.size.height)!, width: (weakSelf?.bgView.frame.size.width)!, height: (weakSelf?.bgView.frame.size.height)!)
            weakSelf?.backgroundView.alpha = 0
            
        }) { (finished) in
            weakSelf?.removeFromSuperview()
        }
    }
    /// 隐藏
    func hide(){
        removeAnimation()
    }
    
    /// 点击bgView不消失
    @objc func onBlankClicked(){
        
    }
    
    /// 点击空白取消
    @objc func onTapCancle(sender:UITapGestureRecognizer){
        
        hide()
    }
    
    /// 操作
    @objc func clickedOperatorBtn(sender: UIButton){
        if action != nil {
            action!(self,sender.tag)
        }
        hide()
    }
    
}

