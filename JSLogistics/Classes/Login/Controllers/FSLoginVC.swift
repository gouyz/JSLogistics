//
//  FSLoginVC.swift
//  fitsky
//  登录
//  Created by gouyz on 2019/7/12.
//  Copyright © 2019 gyz. All rights reserved.
//

import UIKit
import MBProgressHUD

class FSLoginVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarBgAlpha = 0
        self.view.backgroundColor = kBlueBackgroundColor
        
        let leftBtn = UIButton(type: .custom)
        leftBtn.setTitle("游客身份", for: .normal)
        leftBtn.titleLabel?.font = k13Font
        leftBtn.setTitleColor(kWhiteColor, for: .normal)
        leftBtn.frame = CGRect.init(x: 0, y: 0, width: kTitleHeight, height: kTitleHeight)
        leftBtn.addTarget(self, action: #selector(onClickLeftBtn), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
        leftBtn.sizeToFit() // 解决iOS11以下，显示不全
        
        let rightBtn = UIButton(type: .custom)
        rightBtn.setTitle("密码登录", for: .normal)
        rightBtn.titleLabel?.font = k13Font
        rightBtn.setTitleColor(kWhiteColor, for: .normal)
        rightBtn.frame = CGRect.init(x: 0, y: 0, width: kTitleHeight, height: kTitleHeight)
        rightBtn.addTarget(self, action: #selector(onClickRightBtn), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        rightBtn.sizeToFit()
        
        setUpUI()
        
    }
    func setUpUI(){
        
        view.addSubview(logoImgView)
        view.addSubview(phoneInputView)
        view.addSubview(codeBtn)
        view.addSubview(desLab)
        view.addSubview(thirdDesLab)
        view.addSubview(qqBtn)
        view.addSubview(wechatBtn)
        view.addSubview(sinaBtn)
        
        logoImgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(20 + kTitleAndStateHeight)
            make.size.equalTo(CGSize.init(width: 140, height: 46))
        }
        
        phoneInputView.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(logoImgView.snp.bottom).offset(60)
            make.height.equalTo(kUIButtonHeight)
        }
        codeBtn.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(phoneInputView)
            make.top.equalTo(phoneInputView.snp.bottom).offset(40)
        }
        desLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(codeBtn)
            make.top.equalTo(codeBtn.snp.bottom).offset(kMargin)
            make.height.equalTo(20)
        }
        
        qqBtn.snp.makeConstraints { (make) in
            make.left.equalTo(codeBtn)
            make.bottom.equalTo(-60)
            make.size.equalTo(CGSize.init(width: kTitleHeight, height: kTitleHeight))
        }
        wechatBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.bottom.size.equalTo(qqBtn)
        }
        sinaBtn.snp.makeConstraints { (make) in
            make.right.equalTo(codeBtn)
            make.bottom.size.equalTo(qqBtn)
        }
        thirdDesLab.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(desLab)
            make.bottom.equalTo(qqBtn.snp.top).offset(-kMargin)
        }
    }
    
    /// logo
    lazy var logoImgView: UIImageView = UIImageView.init(image: UIImage.init(named: "app_logo_fitsky"))
    /// 手机号
    lazy var phoneInputView: GYZLoginInputView = {
        let phoneView = GYZLoginInputView.init(iconName: "app_icon_phone", keyType: .numberPad)
        
        phoneView.borderColor = kWhiteColor
        phoneView.cornerRadius = kCornerRadius
        phoneView.borderWidth = klineWidth
        phoneView.backgroundColor = kBlueBackgroundColor
        
        phoneView.textFiled.attributedPlaceholder = NSAttributedString.init(string: "请输入手机号", attributes: [NSAttributedString.Key.foregroundColor:kWhiteColor, NSAttributedString.Key.font: k15Font])
        
        return phoneView
        
    }()
    /// 获取验证码
    lazy var codeBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.setTitle("获取验证码", for: .normal)
        btn.titleLabel?.font = k18Font
        btn.backgroundColor = kBtnClickBGColor
        btn.cornerRadius = kCornerRadius
        
        btn.addTarget(self, action: #selector(clickedGetCodeBtn), for: .touchUpInside)
        
        return btn
    }()
    ///
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kWhiteColor
        lab.font = k13Font
        lab.textAlignment = .center
        lab.text = "未注册手机验证后自动登录"
        
        return lab
    }()
    ///
    lazy var thirdDesLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kWhiteColor
        lab.font = k13Font
        lab.textAlignment = .center
        lab.text = "第三方登录"
        
        return lab
    }()
    
    /// qq登录
    lazy var qqBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "app_icon_qq"), for: .normal)
        btn.backgroundColor = kBlueBackgroundColor
        btn.tag = 101
        
        btn.addTarget(self, action: #selector(clickedThirdLoginBtn(sender:)), for: .touchUpInside)
        
        return btn
    }()
    /// 微信登录
    lazy var wechatBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "app_icon_weixin"), for: .normal)
        btn.backgroundColor = kBlueBackgroundColor
        btn.tag = 102
        
        btn.addTarget(self, action: #selector(clickedThirdLoginBtn(sender:)), for: .touchUpInside)
        
        return btn
    }()
    /// 新浪登录
    lazy var sinaBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "app_icon_weibo"), for: .normal)
        btn.backgroundColor = kBlueBackgroundColor
        btn.tag = 103
        
        btn.addTarget(self, action: #selector(clickedThirdLoginBtn(sender:)), for: .touchUpInside)
        
        return btn
    }()
    /// 游客身份
    @objc func onClickLeftBtn(){
    }
    /// 密码登录
    @objc func onClickRightBtn(){
        let vc = FSPwdLoginVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    /// 获取验证码
    @objc func clickedGetCodeBtn(){
        if phoneInputView.textFiled.text!.isEmpty {
            MBProgressHUD.showAutoDismissHUD(message: "请输入手机号")
            return
        }else if !phoneInputView.textFiled.text!.isMobileNumber(){
            MBProgressHUD.showAutoDismissHUD(message: "请输入正确的手机号")
            return
        }
        
        requestCode()
    }
    
    /// 第三方登录
    @objc func clickedThirdLoginBtn(sender: UIButton){
        goBindVC()
    }
    /// 注册验证码
    func goRegisterCodeVC(){
        let vc = FSRegisterCodeVC()
        vc.phoneNum = phoneInputView.textFiled.text!
        navigationController?.pushViewController(vc, animated: true)
    }
    /// 登录验证码
    func goLoginCodeVC(){
        let vc = FSForgetPwdCodeVC()
        vc.isPhoneLogin = true
        vc.phoneNum = phoneInputView.textFiled.text!
        navigationController?.pushViewController(vc, animated: true)
    }
    /// 绑定手机号
    func goBindVC(){
        let vc = FSBindPhoneVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    ///获取验证码
    func requestCode(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "获取中...")
        
        GYZNetWork.requestNetwork("Message/Sms/sendSMS", parameters: ["mobile":phoneInputView.textFiled.text!,"sms_type":1],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            if response["result"].intValue == kQuestSuccessTag{//请求成功
                let isLogin: Int = response["data"]["is_login"].intValue
                if isLogin == 1{//0-注册 1-登录
                    weakSelf?.goLoginCodeVC()
                }else{
                    weakSelf?.goRegisterCodeVC()
                }
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
}
