//
//  FSBindPhoneVC.swift
//  fitsky
//  绑定手机号
//  Created by gouyz on 2019/7/17.
//  Copyright © 2019 gyz. All rights reserved.
//

import UIKit

class FSBindPhoneVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarBgAlpha = 0
        self.navigationItem.title = "绑定手机号"
        self.view.backgroundColor = kBlueBackgroundColor
        
        
        setUpUI()
        
    }
    func setUpUI(){
        
        view.addSubview(phoneInputView)
        view.addSubview(bgView)
        bgView.addSubview(codeInputView)
        bgView.addSubview(codeBtn)
        view.addSubview(loginBtn)
        
        phoneInputView.snp.makeConstraints { (make) in
            make.top.equalTo(kTitleAndStateHeight * 2)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
        }
        bgView.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(phoneInputView)
            make.top.equalTo(phoneInputView.snp.bottom).offset(30)
        }
        codeInputView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(bgView)
            make.right.equalTo(codeBtn.snp.left)
        }
        codeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.centerY.equalTo(bgView)
            make.size.equalTo(CGSize.init(width: 80, height: 30))
        }
        loginBtn.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(phoneInputView)
            make.top.equalTo(bgView.snp.bottom).offset(30)
        }
    }
    
    /// 手机号
    lazy var phoneInputView: GYZLoginInputView = {
        let phoneView = GYZLoginInputView.init(iconName: "app_icon_phone", keyType: .numberPad)
        
        phoneView.borderColor = kWhiteColor
        phoneView.cornerRadius = kCornerRadius
        phoneView.borderWidth = klineWidth
        phoneView.backgroundColor = kBlueBackgroundColor
        
        phoneView.textFiled.attributedPlaceholder = NSAttributedString.init(string: "输入手机号用于绑定", attributes: [NSAttributedString.Key.foregroundColor:kWhiteColor, NSAttributedString.Key.font: k15Font])
        
        return phoneView
        
    }()
    lazy var bgView: UIView = {
        let codeView = UIView()
        codeView.borderColor = kWhiteColor
        codeView.cornerRadius = kCornerRadius
        codeView.borderWidth = klineWidth
        codeView.backgroundColor = kBlueBackgroundColor
        
        return codeView
    }()
    /// 验证码
    lazy var codeInputView: GYZLoginInputView = {
        let phoneView = GYZLoginInputView.init(iconName: "icon_login_code", keyType: .numberPad)
        
        phoneView.backgroundColor = kBlueBackgroundColor
        phoneView.textFiled.attributedPlaceholder = NSAttributedString.init(string: "输入验证码", attributes: [NSAttributedString.Key.foregroundColor:kWhiteColor, NSAttributedString.Key.font: k15Font])
        
        return phoneView
        
    }()
    /// 获取验证码按钮
    lazy var codeBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("获取验证码", for: .normal)
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.titleLabel?.font = k13Font
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = kBtnClickBGColor
        btn.addTarget(self, action: #selector(clickedCodeBtn), for: .touchUpInside)
        
        btn.cornerRadius = kCornerRadius
        
        return btn
    }()
    /// 立即登录按钮
    lazy var loginBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("立即登录", for: .normal)
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.titleLabel?.font = k18Font
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = kBtnClickBGColor
        btn.addTarget(self, action: #selector(clickedLoginBtn), for: .touchUpInside)
        
        btn.cornerRadius = kCornerRadius
        
        return btn
    }()
    
    /// 获取验证码按钮
    @objc func clickedCodeBtn(){
        
    }
    /// 立即登录按钮
    @objc func clickedLoginBtn(){
        
    }
}
