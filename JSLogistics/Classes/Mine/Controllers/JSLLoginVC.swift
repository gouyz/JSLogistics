//
//  JSLLoginVC.swift
//  JSLogistics
//  登录
//  Created by gouyz on 2019/11/1.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

class JSLLoginVC: GYZBaseVC {
    
    let ruleContent: String = "已阅读并同意《用户协议》和《隐私政策》"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = kWhiteColor
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_login_closed")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedRightBtn))
        
        setUpUI()
        
        ruleLab.yb_addAttributeTapAction(["《用户协议》","《隐私政策》"]) {[unowned self] (string, range, index) in
            print("点击了\(string)标签 - {\(range.location) , \(range.length)} - \(index)")
            if index == 0{//用户协议
//                self.goWebVC(method: "News/Home/userAgreement")
            }else{//隐私协议
//                self.goWebVC(method: "News/Home/privacyAgreement")
            }
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setUpUI(){
        
        view.addSubview(bgImgView)
        view.addSubview(closeBtn)
        view.addSubview(logoImgView)
        view.addSubview(desLab)
        view.addSubview(phoneView)
        phoneView.addSubview(phoneTextFiled)
        view.addSubview(codeView)
        codeView.addSubview(codeTextFiled)
        codeView.addSubview(codeBtn)
        view.addSubview(checkImgView)
        view.addSubview(ruleLab)
        view.addSubview(loginBtn)
        view.addSubview(wechatBtn)
        
        logoImgView.backgroundColor = kGaryFontColor
        
        bgImgView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(view)
            make.height.equalTo(kScreenWidth * 0.55)
        }
        closeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(kStateHeight)
            make.size.equalTo(CGSize.init(width: kTitleHeight, height: kTitleHeight))
        }
        logoImgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(bgImgView.snp.bottom)
            make.size.equalTo(CGSize.init(width: 110, height: 110))
        }
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(logoImgView.snp.bottom).offset(kMargin)
            make.height.equalTo(kTitleHeight)
        }
        phoneView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(desLab.snp.bottom).offset(kMargin)
            make.width.equalTo(300)
            make.height.equalTo(kTitleHeight)
        }
        phoneTextFiled.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.bottom.equalTo(phoneView)
        }
        codeView.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(phoneView)
            make.top.equalTo(phoneView.snp.bottom).offset(kMargin)
        }
        codeTextFiled.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(codeBtn.snp.left).offset(kMargin)
            make.top.bottom.equalTo(codeView)
        }
        codeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.width.equalTo(80)
            make.top.bottom.equalTo(codeView)
        }
        ruleLab.snp.makeConstraints { (make) in
            make.left.equalTo(checkImgView.snp.right).offset(kMargin)
            make.top.equalTo(codeView.snp.bottom).offset(kMargin)
            make.height.equalTo(30)
            make.right.equalTo(codeView)
        }
        checkImgView.snp.makeConstraints { (make) in
            make.left.equalTo(codeView)
            make.centerY.equalTo(ruleLab)
            make.size.equalTo(CGSize.init(width: 20, height: 18))
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(codeView)
            make.top.equalTo(ruleLab.snp.bottom).offset(kTitleHeight)
            make.height.equalTo(kTitleHeight)
        }
        wechatBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(loginBtn.snp.bottom).offset(20)
            make.size.equalTo(CGSize.init(width: 60, height: kTitleHeight))
        }
    }
    /// 关闭
    lazy var closeBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "icon_login_closed"), for: .normal)
        btn.addTarget(self, action: #selector(clickedRightBtn), for: .touchUpInside)
        
        return btn
    }()
    /// logo
    lazy var bgImgView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_login_bg"))
    /// logo
    lazy var logoImgView: UIImageView = UIImageView.init(image: UIImage.init(named: "app_logo_fitsky"))
    ///
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k18Font
        lab.textAlignment = .center
        lab.text = "现在就加入即时美食的大家庭吧！"
        
        return lab
    }()
    
    lazy var phoneView: UIView = {
        let bgView = UIView()
        bgView.borderColor = kGrayLineColor
        bgView.cornerRadius = 4
        bgView.borderWidth = klineWidth
        
        return bgView
    }()
    /// 输入框
    lazy var phoneTextFiled : UITextField = {
        
        let textFiled = UITextField()
        textFiled.font = k15Font
        textFiled.textColor = kBlackFontColor
        textFiled.clearButtonMode = .whileEditing
        textFiled.placeholder = "请输入手机号码"
        
        return textFiled
    }()
    lazy var codeView: UIView = {
        let bgView = UIView()
        bgView.borderColor = kGrayLineColor
        bgView.cornerRadius = 4
        bgView.borderWidth = klineWidth
        bgView.isUserInteractionEnabled = true
        
        return bgView
    }()
    /// 输入框
    lazy var codeTextFiled : UITextField = {
        
        let textFiled = UITextField()
        textFiled.font = k15Font
        textFiled.textColor = kBlackFontColor
        textFiled.clearButtonMode = .whileEditing
        textFiled.placeholder = "请输入验证码"
        
        return textFiled
    }()
    /// 获取验证码
    lazy var codeBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitleColor(kGaryFontColor, for: .normal)
        btn.setTitle("获取验证码", for: .normal)
        btn.titleLabel?.font = k13Font
        btn.cornerRadius = kCornerRadius
        
        btn.addTarget(self, action: #selector(clickedGetCodeBtn), for: .touchUpInside)
        
        return btn
    }()
    lazy var checkImgView: UIImageView = {
        let imgView = UIImageView.init(image: UIImage.init(named: "icon_check_squal_no"))
        imgView.highlightedImage = UIImage.init(named: "icon_check_squal_yes")
        imgView.addOnClickListener(target: self, action: #selector(clickedCheckRule))
        
        return imgView
    }()
    lazy var ruleLab: UILabel = {
        let lab = UILabel()
        let attStr = NSMutableAttributedString.init(string: ruleContent)
        attStr.addAttribute(NSAttributedString.Key.font, value: k13Font, range: NSMakeRange(0, ruleContent.count))
       attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: kGaryFontColor, range: NSMakeRange(0, ruleContent.count))
        attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: kGreenFontColor, range: NSMakeRange(6, 6))
        attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: kGreenFontColor, range: NSMakeRange(13, 6))
        
        lab.attributedText = attStr
        /// 点击效果，关闭
        lab.enabledTapEffect = false
        lab.numberOfLines = 0
        
        return lab
    }()
    
    /// 登录
    lazy var loginBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("登录", for: .normal)
        btn.titleLabel?.font = k15Font
        btn.backgroundColor = kBtnNoClickBGColor
        btn.setTitleColor(kGaryFontColor, for: .disabled)
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.cornerRadius = kCornerRadius
        
        return btn
    }()
    /// 微信登录
    lazy var wechatBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "icon_login_wechat"), for: .normal)
        
        return btn
    }()
    /// 关闭
    @objc func clickedRightBtn(){
        self.dismiss(animated: true) {
            
        }
    }
    /// 获取验证码
    @objc func clickedGetCodeBtn(){
//        if phoneInputView.textFiled.text!.isEmpty {
//            MBProgressHUD.showAutoDismissHUD(message: "请输入手机号")
//            return
//        }else if !phoneInputView.textFiled.text!.isMobileNumber(){
//            MBProgressHUD.showAutoDismissHUD(message: "请输入正确的手机号")
//            return
//        }
//
//        requestCode()
    }
    
    /// 第三方登录
    @objc func clickedThirdLoginBtn(sender: UIButton){
        
    }
    
    /// 同意协议按钮
    @objc func clickedCheckRule(){
        checkImgView.isHighlighted = !checkImgView.isHighlighted
    }

}
