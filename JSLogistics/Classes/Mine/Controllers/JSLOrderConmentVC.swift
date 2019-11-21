//
//  JSLOrderConmentVC.swift
//  JSLogistics
//  商品评价
//  Created by gouyz on 2019/10/30.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD
import DKImagePickerController
import Cosmos

class JSLOrderConmentVC: GYZBaseVC {
    
    /// 选择结果回调
    var resultBlock:(() -> Void)?
    
    ///txtView 提示文字
    let placeHolder = "您对我们的商品有什么意见或者建议，商品的有点或者美中不足的地方都可以说说"
    /// 选择的图片
    var selectImgs: [UIImage] = []
    /// 最大选择图片数量
    var maxImgCount: Int = kMaxSelectCount
    /// 图片上传后的路径
    var imgUrls: String = ""
    // 内容
    var content: String = ""
    var orderId: String = ""
    var goodsImgUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = kWhiteColor
        self.navigationItem.title = "商品评价"
        
        let rightBtn = UIButton(type: .custom)
        rightBtn.setTitle("提交", for: .normal)
        rightBtn.titleLabel?.font = k15Font
        rightBtn.setTitleColor(kGreenFontColor, for: .normal)
        rightBtn.frame = CGRect.init(x: 0, y: 0, width: kTitleHeight, height: kTitleHeight)
        rightBtn.addTarget(self, action: #selector(onClickRightBtn), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        
        setUpUI()
        
        contentTxtView.delegate = self
        contentTxtView.text = placeHolder
        goodImgView.kf.setImage(with: URL.init(string: goodsImgUrl))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI(){
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(goodImgView)
        contentView.addSubview(desLab)
        contentView.addSubview(ratingView)
        contentView.addSubview(lineView)
        
        contentView.addSubview(contentTxtView)
        contentView.addSubview(addPhotosView)
        
        contentView.addSubview(lineView1)
        contentView.addSubview(tagImgView)
        contentView.addSubview(desLab1)
        contentView.addSubview(desLab2)
        contentView.addSubview(serviceRatingView)
        contentView.addSubview(desLab3)
        contentView.addSubview(wlRatingView)
        
        addPhotosView.delegate = self
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.width.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            // 这个很重要！！！！！！
            // 必须要比scroll的高度大一，这样才能在scroll没有填充满的时候，保持可以拖动
            make.height.greaterThanOrEqualTo(scrollView).offset(1)
        }
        desLab.snp.makeConstraints { (make) in
            make.top.equalTo(kMargin)
            make.left.equalTo(goodImgView.snp.right).offset(kMargin)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        goodImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(desLab)
            make.left.equalTo(kMargin)
            make.size.equalTo(CGSize.init(width: 36, height: 36))
        }
        ratingView.snp.makeConstraints { (make) in
            make.centerY.equalTo(desLab)
            make.left.equalTo(desLab.snp.right)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(desLab.snp.bottom)
            make.height.equalTo(klineWidth)
        }
        contentTxtView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(lineView.snp.bottom).offset(kMargin)
            make.height.equalTo(120)
        }
        addPhotosView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentTxtView)
            make.top.equalTo(contentTxtView.snp.bottom).offset(kMargin)
            make.height.equalTo(kPhotosImgHeight3)
        }
        lineView1.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.top.equalTo(addPhotosView.snp.bottom).offset(kMargin)
        }
        desLab1.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgView.snp.right).offset(kMargin)
            make.top.equalTo(lineView1.snp.bottom)
            make.right.equalTo(-kMargin)
            make.height.equalTo(kTitleHeight)
        }
        tagImgView.snp.makeConstraints { (make) in
            make.left.equalTo(goodImgView)
            make.centerY.equalTo(desLab1)
            make.size.equalTo(CGSize.init(width: 15, height: 12))
        }
        desLab2.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(desLab1.snp.bottom)
            make.width.equalTo(desLab)
            make.height.equalTo(desLab)
        }
        serviceRatingView.snp.makeConstraints { (make) in
            make.centerY.equalTo(desLab2)
            make.left.equalTo(desLab2.snp.right)
            make.width.height.equalTo(ratingView)
        }
        desLab3.snp.makeConstraints { (make) in
            make.left.width.height.equalTo(desLab2)
            make.top.equalTo(desLab2.snp.bottom)
            // 这个很重要，viewContainer中的最后一个控件一定要约束到bottom，并且要小于等于viewContainer的bottom
            // 否则的话，上面的控件会被强制拉伸变形
            // 最后的-10是边距，这个可以随意设置
            make.bottom.lessThanOrEqualTo(contentView).offset(-kMargin)
        }
        wlRatingView.snp.makeConstraints { (make) in
            make.centerY.equalTo(desLab3)
            make.left.equalTo(desLab3.snp.right)
            make.width.height.equalTo(ratingView)
        }
    }
    
    /// scrollView
    var scrollView: UIScrollView = UIScrollView()
    /// 内容View
    var contentView: UIView = UIView()
    lazy var goodImgView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_logo_circle"))
    ///
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "商品打分"
        
        return lab
    }()
    ///星星评分
    lazy var ratingView: CosmosView = {
        
        let ratingStart = CosmosView()
        ratingStart.settings.fillMode = .full
        ratingStart.settings.filledColor = kGreenFontColor
        ratingStart.settings.emptyBorderColor = kGaryFontColor
        ratingStart.settings.filledBorderColor = kGreenFontColor
        ratingStart.settings.starMargin = 5
        ratingStart.settings.starSize = 30
        ratingStart.rating = 5
        
        return ratingStart
        
    }()
    /// 分割线
    var lineView : UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        return line
    }()
    /// 描述
    lazy var contentTxtView: UITextView = {
        
        let txtView = UITextView()
        txtView.font = k15Font
        txtView.textColor = kGaryFontColor
        
        return txtView
    }()
    /// 添加照片View
    lazy var addPhotosView: LHSAddPhotoView = LHSAddPhotoView.init(frame: CGRect.zero, maxCount: maxImgCount)
    
    /// 分割线
    var lineView1 : UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        return line
    }()
    lazy var tagImgView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_seller_tag_default"))
    ///
    lazy var desLab1 : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "店铺服务"
        
        return lab
    }()
    ///
    lazy var desLab2 : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "服务打分"
        
        return lab
    }()
    ///星星评分
    lazy var serviceRatingView: CosmosView = {
        
        let ratingStart = CosmosView()
        ratingStart.settings.fillMode = .full
        ratingStart.settings.filledColor = kGreenFontColor
        ratingStart.settings.emptyBorderColor = kGaryFontColor
        ratingStart.settings.filledBorderColor = kGreenFontColor
        ratingStart.settings.starMargin = 5
        ratingStart.settings.starSize = 30
        ratingStart.rating = 5
        
        return ratingStart
        
    }()
    ///
    lazy var desLab3 : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "店铺打分"
        
        return lab
    }()
    ///星星评分
    lazy var wlRatingView: CosmosView = {
        
        let ratingStart = CosmosView()
        ratingStart.settings.fillMode = .full
        ratingStart.settings.filledColor = kGreenFontColor
        ratingStart.settings.emptyBorderColor = kGaryFontColor
        ratingStart.settings.filledBorderColor = kGreenFontColor
        ratingStart.settings.starMargin = 5
        ratingStart.settings.starSize = 30
        ratingStart.rating = 5
        
        return ratingStart
        
    }()
    ///打开相机
    func openCamera(){
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            MBProgressHUD.showAutoDismissHUD(message: "该设备无摄像头")
            return
        }
        
        GYZOpenCameraPhotosTool.shareTool.checkCameraPermission { (granted) in
            if granted{
                let photo = UIImagePickerController()
                photo.delegate = self
                photo.sourceType = .camera
                photo.allowsEditing = true
                self.present(photo, animated: true, completion: nil)
            }else{
                GYZOpenCameraPhotosTool.shareTool.showPermissionAlert(content: "请在iPhone的“设置-隐私”选项中，允许访问你的摄像头",controller : self)
            }
        }
        
    }
    
    ///打开相册
    func openPhotos(){
        
        let pickerController = DKImagePickerController()
        pickerController.maxSelectableCount = maxImgCount
        pickerController.sourceType = .photo
        
        weak var weakSelf = self
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            
            var count = 0
            for item in assets {
                item.fetchFullScreenImage(completeBlock: { (image, info) in
                    weakSelf?.selectImgs.append(image!)
                    weakSelf?.maxImgCount = kMaxSelectCount - (weakSelf?.selectImgs.count)!
                    
                    count += 1
                    if count == assets.count{
                        weakSelf?.resetAddImgView()
                    }
                })
            }
        }
        pickerController.modalPresentationStyle = .fullScreen
        self.present(pickerController, animated: true) {}
    }
    
    /// 发表
    @objc func onClickRightBtn(){
        
        if contentTxtView.text.isEmpty || contentTxtView.text == placeHolder{
            MBProgressHUD.showAutoDismissHUD(message: "请输入评论内容")
            return
        }
        createHUD(message: "加载中...")
        if selectImgs.count > 0 {
            for (index,imgItem) in selectImgs.enumerated() {
                let imgParam: ImageFileUploadParam = ImageFileUploadParam()
                imgParam.name = "image"
                imgParam.fileName = "dynamic\(index).jpg"
                imgParam.mimeType = "image/jpg"
                imgParam.data = UIImage.jpegData(imgItem)(compressionQuality: 0.5)!
                
                uploadImgFiles(imgsParam: [imgParam],index: index)
            }
        }else{
            requestPublishDynamic()
        }
    }
    
    /// 上传图片
    ///
    /// - Parameter params: 参数
    func uploadImgFiles(imgsParam: [ImageFileUploadParam],index:Int){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        
        GYZNetWork.uploadImageRequest("user/upload_image", parameters: nil, uploadParam: imgsParam, success: { (response) in
            
            GYZLog(response)
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                weakSelf?.imgUrls += response["url"].stringValue + ","
                
                if index == (weakSelf?.selectImgs.count)! - 1 {
                    if weakSelf?.imgUrls.count > 0{
                        weakSelf?.imgUrls = (weakSelf?.imgUrls.subString(start: 0, length: (weakSelf?.imgUrls.count)! - 1))!
                    }
                    weakSelf?.requestPublishDynamic()
                }
            }else{
                weakSelf?.hud?.hide(animated: true)
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    
    ///发布动态-提交
    func requestPublishDynamic(){
        if !GYZTool.checkNetWork() {
            return
        }
        weak var weakSelf = self

        let paramDic: [String:Any] = ["content":contentTxtView.text!,"order_id":orderId,"user_id":userDefaults.string(forKey: "userId") ?? "","img":imgUrls,"goods_rank":ratingView.rating,"store_rank":wlRatingView.rating,"service_rank":serviceRatingView.rating]

        GYZNetWork.requestNetwork("order/addComment", parameters: paramDic,  success: { (response) in

            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                weakSelf?.dealData()
            }

        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    
    func dealData(){
        if resultBlock != nil {
            resultBlock!()
        }
        
        clickedBackBtn()
    }
}

extension JSLOrderConmentVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        guard let image = info[picker.allowsEditing ? UIImagePickerController.InfoKey.editedImage : UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        picker.dismiss(animated: true) { [weak self] in
            
            if self?.selectImgs.count == kMaxSelectCount{
                MBProgressHUD.showAutoDismissHUD(message: "最多只能上传\(kMaxSelectCount)张图片")
                return
            }
            self?.selectImgs.append(image)
            self?.maxImgCount -= 1
            self?.resetAddImgView()
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    /// 选择图片后重新设置图片显示
    func resetAddImgView(){
        var rowIndex = ceil(CGFloat.init(selectImgs.count) / 3.0)//向上取整
        /// 预留出增加按钮位置
        if selectImgs.count < kMaxSelectCount && selectImgs.count % 3 == 0 {
            rowIndex += 1
        }
        let height = kPhotosImgHeight3 * rowIndex + kMargin * (rowIndex - 1)
        
        addPhotosView.snp.updateConstraints({ (make) in
            make.height.equalTo(height)
        })
        addPhotosView.selectImgs = selectImgs
    }
}

extension JSLOrderConmentVC : UITextViewDelegate,LHSAddPhotoViewDelegate
{
    ///MARK LHSAddPhotoViewDelegate
    ///添加图片
    func didClickAddImage(photoView: LHSAddPhotoView) {
        GYZAlertViewTools.alertViewTools.showSheet(title: "选择照片", message: nil, cancleTitle: "取消", titleArray: ["拍照","从相册选取"], viewController: self) { [weak self](index) in
            
            if index == 0{//拍照
                self?.openCamera()
            }else if index == 1 {//从相册选取
                self?.openPhotos()
            }
        }
    }
    
    func didClickDeleteImage(index: Int, photoView: LHSAddPhotoView) {
        selectImgs.remove(at: index)
        maxImgCount += 1
        resetAddImgView()
    }
    
    ///MARK UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        let text = textView.text
        if text == placeHolder {
            textView.text = ""
            textView.textColor = kBlackFontColor
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.text = placeHolder
            textView.textColor = kGaryFontColor
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        
        content = textView.text
    }
}
