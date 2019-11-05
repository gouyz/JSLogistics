//
//  JSLPublishVC.swift
//  JSLogistics
//  发布笔记
//  Created by gouyz on 2019/8/7.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD
import Cosmos
import SKPhotoBrowser

class JSLPublishVC: GYZBaseVC {
    
    ///txtView 提示文字
    let placeHolder = "内容分享的第一句话会在主页显示哦！"
    // 拍照
    var selectCameraImgs: [UIImage] = [UIImage]()
    /// 最大选择图片数量
    var maxImgCount: Int = kMaxSelectCount
    /// 已选择图片数量
    var selectImgCount: Int = 0
    /// 是否是视频
    var isVideo: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "发布笔记"
        self.view.backgroundColor = kWhiteColor
        
        let rightBtn = UIButton(type: .custom)
        rightBtn.setTitle("发布", for: .normal)
        rightBtn.titleLabel?.font = k15Font
        rightBtn.setTitleColor(kWhiteColor, for: .normal)
        rightBtn.backgroundColor = kGreenFontColor
        rightBtn.cornerRadius = kCornerRadius
        rightBtn.frame = CGRect.init(x: 0, y: 7, width: 50, height: 30)
        rightBtn.addTarget(self, action: #selector(onClickRightBtn), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        
        setUpUI()
        contentTxtView.delegate = self
        contentTxtView.text = placeHolder
        
    }
    func setUpUI(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleTextFiled)
        contentView.addSubview(lineView)
        contentView.addSubview(contentTxtView)
        contentView.addSubview(lineView1)
        contentView.addSubview(addPhotosView)
        contentView.addSubview(lineView2)
        contentView.addSubview(tagView)
        contentView.addSubview(rightIconView)
        contentView.addSubview(lineView3)
        contentView.addSubview(zuoBiaoView)
        contentView.addSubview(rightIconView1)
        contentView.addSubview(lineView4)
        contentView.addSubview(categoryView)
        contentView.addSubview(rightIconView2)
        contentView.addSubview(lineView6)
        contentView.addSubview(tuijianLab)
        contentView.addSubview(tuijianRatingView)
        contentView.addSubview(lineView5)
        
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
        titleTextFiled.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(contentView)
            make.height.equalTo(50)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(titleTextFiled.snp.bottom)
            make.height.equalTo(klineWidth)
        }
        contentTxtView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(kMargin)
            make.left.right.equalTo(titleTextFiled)
            make.height.equalTo(120)
        }
        lineView1.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.top.equalTo(contentTxtView.snp.bottom)
        }
        addPhotosView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentTxtView)
            make.top.equalTo(lineView1.snp.bottom).offset(kMargin)
            make.height.equalTo(kPhotosImgHeight)
        }
        lineView2.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.top.equalTo(addPhotosView.snp.bottom).offset(kMargin)
        }
        tagView.snp.makeConstraints { (make) in
            make.height.equalTo(titleTextFiled)
            make.left.equalTo(contentView)
            make.top.equalTo(lineView2.snp.bottom)
            make.right.equalTo(rightIconView.snp.left)
        }
        rightIconView.snp.makeConstraints { (make) in
            make.centerY.equalTo(tagView)
            make.right.equalTo(-kMargin)
            make.size.equalTo(rightArrowSize)
        }
        lineView3.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.top.equalTo(tagView.snp.bottom)
        }
        zuoBiaoView.snp.makeConstraints { (make) in
            make.left.height.equalTo(tagView)
            make.top.equalTo(lineView3.snp.bottom)
            make.right.equalTo(rightIconView1.snp.left)
        }
        rightIconView1.snp.makeConstraints { (make) in
            make.centerY.equalTo(zuoBiaoView)
            make.right.equalTo(-kMargin)
            make.size.equalTo(rightArrowSize)
        }
        lineView4.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.top.equalTo(zuoBiaoView.snp.bottom)
        }
        categoryView.snp.makeConstraints { (make) in
            make.left.height.equalTo(tagView)
            make.top.equalTo(lineView4.snp.bottom)
            make.right.equalTo(rightIconView2.snp.left)
        }
        rightIconView2.snp.makeConstraints { (make) in
            make.centerY.equalTo(categoryView)
            make.right.equalTo(-kMargin)
            make.size.equalTo(rightArrowSize)
        }
        lineView6.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.top.equalTo(categoryView.snp.bottom)
        }
        tuijianLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(lineView6.snp.bottom)
            make.width.equalTo(100)
            make.height.equalTo(titleTextFiled)
        }
        tuijianRatingView.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.centerY.equalTo(tuijianLab)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        lineView5.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.top.equalTo(tuijianLab.snp.bottom)
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
    
    /// 标题
    lazy var titleTextFiled : UITextField = {
        
        let textFiled = UITextField()
        textFiled.font = k15Font
        textFiled.textColor = kBlackFontColor
        textFiled.clearButtonMode = .whileEditing
        textFiled.placeholder = "标题写的好，粉丝涨不少"
        
        return textFiled
    }()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = kGrayLineColor
        
        return view
    }()
    /// 描述
    lazy var contentTxtView: UITextView = {
        
        let txtView = UITextView()
        txtView.font = k15Font
        txtView.textColor = kGaryFontColor
        
        return txtView
    }()
    lazy var lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = kGrayLineColor
        
        return view
    }()
    
    /// 添加照片View
    lazy var addPhotosView: LHSAddPhotoView = LHSAddPhotoView.init(frame: CGRect.zero, maxCount: maxImgCount)
    lazy var lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = kGrayLineColor
        
        return view
    }()
    /// 选择美食标签
    lazy var tagView: GYZLabAndFieldView = {
        let selectView = GYZLabAndFieldView()
        selectView.desLab.text = "美食标签"
        selectView.textFiled.isEnabled = false
        selectView.textFiled.placeholder = "添加美食标签让更多的人发现你"
        selectView.textFiled.textColor = kGreenFontColor
        selectView.textFiled.textAlignment = .right
        selectView.tag = 101
        selectView.addOnClickListener(target: self, action: #selector(onClickedOperator(sender:)))
        
        return selectView
    }()
    /// 右侧箭头图标
    lazy var rightIconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_right_arrow"))
    lazy var lineView3: UIView = {
        let view = UIView()
        view.backgroundColor = kGrayLineColor
        
        return view
    }()
    /// 选择美食坐标
    lazy var zuoBiaoView: GYZLabAndFieldView = {
        let selectView = GYZLabAndFieldView()
        selectView.desLab.text = "添加套餐"
        selectView.textFiled.isEnabled = false
        selectView.textFiled.textColor = kGreenFontColor
        selectView.textFiled.textAlignment = .right
        selectView.tag = 102
        selectView.addOnClickListener(target: self, action: #selector(onClickedOperator(sender:)))
        
        return selectView
    }()
    /// 右侧箭头图标
    lazy var rightIconView1: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_right_arrow"))
    lazy var lineView4: UIView = {
        let view = UIView()
        view.backgroundColor = kGrayLineColor
        
        return view
    }()
    /// 选择笔记分类
    lazy var categoryView: GYZLabAndFieldView = {
        let selectView = GYZLabAndFieldView()
        selectView.desLab.text = "笔记分类"
        selectView.textFiled.isEnabled = false
        selectView.textFiled.textColor = kGreenFontColor
        selectView.textFiled.textAlignment = .right
        selectView.tag = 103
        selectView.addOnClickListener(target: self, action: #selector(onClickedOperator(sender:)))
        
        return selectView
    }()
    /// 右侧箭头图标
    lazy var rightIconView2: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_right_arrow"))
    lazy var lineView6: UIView = {
        let view = UIView()
        view.backgroundColor = kGrayLineColor
        
        return view
    }()
    /// 推荐指数
    lazy var tuijianLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackFontColor
        lab.font = k15Font
        lab.text = "推荐指数"
        
        return lab
    }()
    ///星星评分
    lazy var tuijianRatingView: CosmosView = {
        
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
    lazy var lineView5: UIView = {
        let view = UIView()
        view.backgroundColor = kGrayLineColor
        
        return view
    }()
    
    // 发布
    @objc func onClickRightBtn(){
//        if contentTxtView.text.isEmpty || contentTxtView.text == placeHolder{
//            MBProgressHUD.showAutoDismissHUD(message: "请输入动态内容")
//            return
//        }
//        if selectCameraImgs.count > 0 {
//            uploadImgFiles()
//        }else{
//            requestPublishDynamic(urls: "")
//        }
    }
    
    /// 上传图片
    ///
    /// - Parameter params: 参数
    func uploadImgFiles(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        createHUD(message: "加载中...")
        weak var weakSelf = self
        
        var imgsParam: [ImageFileUploadParam] = [ImageFileUploadParam]()
        for (index,imgItem) in selectCameraImgs.enumerated() {
            let imgParam: ImageFileUploadParam = ImageFileUploadParam()
            imgParam.name = "files[]"
            imgParam.fileName = "dynamic\(index).jpg"
            imgParam.mimeType = "image/jpg"
            imgParam.data = UIImage.jpegData(imgItem)(compressionQuality: 0.5)!
            
            imgsParam.append(imgParam)
        }
        
        GYZNetWork.uploadImageRequest("Dynamic/Publish/addMaterial", parameters: nil, uploadParam: imgsParam, success: { (response) in
            
            GYZLog(response)
            if response["result"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["data"]["files"].array else { return }
                var urls: String = ""
                for item in data{
                    urls += item["material"].stringValue + ","
                }
                if urls.count > 0{
                    urls = urls.subString(start: 0, length: urls.count - 1)
                }
                weakSelf?.requestPublishDynamic(urls: urls)
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
    func requestPublishDynamic(urls: String){
//        if !GYZTool.checkNetWork() {
//            return
//        }
//
//        if urls == "" {
//            createHUD(message: "加载中...")
//        }
//        weak var weakSelf = self
//
//        var paramDic: [String:Any] = ["content":contentTxtView.text!,"material":urls,"open_type":openType]
//        if topicModel != nil {
//            paramDic["topic_id"] = (topicModel?.id)!
//        }
//        if currAddress != nil {
//            paramDic["position"] = currAddress?.name
//            paramDic["lng"] = currAddress?.location.longitude
//            paramDic["lat"] = currAddress?.location.latitude
//            paramDic["address"] = currAddress?.address
//        }
//
//        GYZNetWork.requestNetwork("Dynamic/Publish/material", parameters: paramDic,  success: { (response) in
//
//            weakSelf?.hud?.hide(animated: true)
//            GYZLog(response)
//            MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
//            if response["result"].intValue == kQuestSuccessTag{//请求成功
//                userDefaults.set(true, forKey: kIsPublishDynamicTagKey)
//                weakSelf?.dealBack()
//            }
//
//        }, failture: { (error) in
//            weakSelf?.hud?.hide(animated: true)
//            GYZLog(error)
//        })
    }
    func dealBack(){
//        if topicModel != nil {
//            var isBack = false
//            for i in 0..<(navigationController?.viewControllers.count)!{
//
//                if navigationController?.viewControllers[i].isKind(of: FSTopicDetailVC.self) == true {
//
//                    isBack = true
//                    let vc = navigationController?.viewControllers[i] as! FSTopicDetailVC
//                    vc.isRefresh = true
//                    _ = navigationController?.popToViewController(vc, animated: true)
//
//                    break
//                }
//            }
//            if !isBack{
//                let _ = self.navigationController?.popToRootViewController(animated: true)
//            }
//            return
//        }
//        let _ = self.navigationController?.popToRootViewController(animated: true)
    }
    //
    @objc func onClickedOperator(sender: UITapGestureRecognizer){
        let tag = sender.view?.tag
        if tag == 101 { //选择标签
            goSelectTag()
        }else if tag == 102 { //谁可以看
//            goSeePower()
        }else if tag == 103 { //选择地点
//            goSelectAddressVC()
        }
    }
    func goSelectTag(){
        let vc = JSLSelectedFoodTagVC()
        let navVC = GYZBaseNavigationVC(rootViewController:vc)
        
        self.present(navVC, animated: true, completion: nil)
    }
    ///打开相机
    func openCamera(){
        if selectImgCount == kMaxSelectCount{
            MBProgressHUD.showAutoDismissHUD(message: "最多只能上传\(kMaxSelectCount)张图片")
            return
        }
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
                photo.modalPresentationStyle = .fullScreen
                self.present(photo, animated: true, completion: nil)
            }else{
                GYZOpenCameraPhotosTool.shareTool.showPermissionAlert(content: "请在iPhone的“设置-隐私”选项中，允许访问你的摄像头",controller : self)
            }
        }
        
    }
    
    /// 手机相册
    func goSelectPhotoVC(){
//        let vc = FSSelectPhotosVC()
//        vc.isBack = true
//        vc.maxImgCount = self.maxImgCount - self.selectImgCount
//        //        vc.selectImgs = self.selectImgs
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func cleanImg(){
        self.selectCameraImgs.removeAll()
        self.selectImgCount = 0
    }
}
extension JSLPublishVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        guard let image = info[picker.allowsEditing ? UIImagePickerController.InfoKey.editedImage : UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        picker.dismiss(animated: true) { [unowned self] in
            
            //            self.cleanImg()
            self.selectCameraImgs.append(image)
            self.selectImgCount += 1
            self.resetAddImgView()
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    /// 选择图片后重新设置图片显示
    func resetAddImgView(){
//        var rowIndex = ceil(CGFloat.init(selectImgCount) / 3.0)//向上取整
//        /// 预留出增加按钮位置
//        if selectImgCount < maxImgCount && selectImgCount % 3 == 0 {
//            rowIndex += 1
//        }
//        let height = kPhotosImgHeight3 * rowIndex + kMargin * (rowIndex - 1)
//
//        addPhotosView.snp.updateConstraints({ (make) in
//            make.height.equalTo(height)
//        })
        addPhotosView.selectImgs = selectCameraImgs
    }
}
extension JSLPublishVC : UITextViewDelegate,LHSAddPhotoViewDelegate
{
    ///MARK LHSAddPhotoViewDelegate
    ///添加图片
    func didClickAddImage(photoView: LHSAddPhotoView) {
        
        contentTxtView.resignFirstResponder()
        
        let actionSheet = GYZActionSheet.init(title: "", style: .Default, itemTitles: ["拍照","来自手机相册"])
        actionSheet.cancleTextColor = kWhiteColor
        actionSheet.cancleTextFont = k15Font
        actionSheet.itemTextColor = kGaryFontColor
        actionSheet.itemTextFont = k15Font
        actionSheet.didSelectIndex = {[weak self] (index,title) in
            if index == 0{//拍照
                self?.openCamera()
            }else if index == 1 {//从相册选取
                self?.goSelectPhotoVC()
            }
        }
    }
    
    func didClickDeleteImage(index: Int, photoView: LHSAddPhotoView) {
        if isVideo {
            maxImgCount = kMaxSelectCount
            addPhotosView.maxImgCount = maxImgCount
        }
        selectCameraImgs.remove(at: index)
        selectImgCount -= 1
        resetAddImgView()
    }
    /// 查看大图
    ///
    /// - Parameters:
    ///   - index: 索引
    ///   - urls: 图片路径
    func goBigPhotos(index: Int){
        let browser = SKPhotoBrowser(photos: GYZTool.createWebPhotosWithImgs(imgs: selectCameraImgs))
        browser.initializePageIndex(index)
        //        browser.delegate = self
        
        present(browser, animated: true, completion: nil)
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
    
}

