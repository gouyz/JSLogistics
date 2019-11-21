//
//  JSLPublishVC.swift
//  JSLogistics
//  发布笔记
//  Created by gouyz on 2019/8/7.
//  Copyright © 2019 gouyz. All rights reserved.
//  7939 151 318 722 885

import UIKit
import MBProgressHUD
import Cosmos
import DKImagePickerController

class JSLPublishVC: GYZBaseVC {
    
    ///txtView 提示文字
    let placeHolder = "内容分享的第一句话会在主页显示哦！"
    /// 选择的图片
    var selectImgs: [UIImage] = [UIImage]()
    /// 最大选择图片数量
    var maxImgCount: Int = kMaxSelectCount
    /// 是否是视频
    var isVideo: Bool = false
    /// 选择美食
    var currGoodsModel: JSLGoodsModel?
    /// 选择美食标签
    var tagNames: String = ""
    /// 图片上传后的路径
    var imgUrls: String = ""
    
    var catrgoryList: [JSLPublishCategoryModel] = [JSLPublishCategoryModel]()
    var categoryNameList:[String] = [String]()
    var selectCategoryIndex: Int = 0
    
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
        
        requestCategoryList()
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
            make.height.equalTo(kPhotosImgHeight3)
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
    /// 添加套餐
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
        if titleTextFiled.text!.isEmpty {
            MBProgressHUD.showAutoDismissHUD(message: "请输入标题")
            return
        }
        if contentTxtView.text.isEmpty || contentTxtView.text == placeHolder{
            MBProgressHUD.showAutoDismissHUD(message: "请输入动态内容")
            return
        }
        if tagNames.count == 0 {
            MBProgressHUD.showAutoDismissHUD(message: "请选择美食标签")
            return
        }
        if currGoodsModel == nil {
            MBProgressHUD.showAutoDismissHUD(message: "请选择美食套餐")
            return
        }
        if selectImgs.count == 0 {
            MBProgressHUD.showAutoDismissHUD(message: "请选择图片")
            return
        }
        createHUD(message: "加载中...")
        
        for (index,imgItem) in selectImgs.enumerated() {
            let imgParam: ImageFileUploadParam = ImageFileUploadParam()
            imgParam.name = "image"
            imgParam.fileName = "dynamic\(index).jpg"
            imgParam.mimeType = "image/jpg"
            imgParam.data = UIImage.jpegData(imgItem)(compressionQuality: 0.5)!
            
            uploadImgFiles(imgsParam: [imgParam],index: index)
        }
    }
    
    ///获取发布分类数据
    func requestCategoryList(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("publish/getPublishType",parameters: nil,method :.get,  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].array else { return }
                for item in data{
                    guard let itemInfo = item.dictionaryObject else { return }
                    let model = JSLPublishCategoryModel.init(dict: itemInfo)
                    
                    weakSelf?.catrgoryList.append(model)
                    weakSelf?.categoryNameList.append(model.name!)
                }
                
                if weakSelf?.catrgoryList.count > 0 {
                    weakSelf?.selectCategoryIndex = 0
                    weakSelf?.categoryView.textFiled.text = weakSelf?.categoryNameList[0]
                }
                
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
            
        })
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

        let paramDic: [String:Any] = ["content":contentTxtView.text!,"title":titleTextFiled.text!,"user_id":userDefaults.string(forKey: "userId") ?? "","img":imgUrls,"tag":tagNames,"goods_id":(currGoodsModel?.goods_id)!,"exponent":tuijianRatingView.rating,"type_id":catrgoryList[selectCategoryIndex].type_id!]

        GYZNetWork.requestNetwork("publish/addPublish", parameters: paramDic,  success: { (response) in

            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                
            }

        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    //
    @objc func onClickedOperator(sender: UITapGestureRecognizer){
        let tag = sender.view?.tag
        if tag == 101 { //选择标签
            goSelectTag()
        }else if tag == 102 { //选择美食
            goSelectGoodsVC()
        }else if tag == 103 { //选择分类
            selectCategory()
        }
    }
    //选择标签
    func goSelectTag(){
        let vc = JSLSelectedFoodTagVC()
        vc.resultBlock = {[unowned self] (names) in
            self.tagNames = names
            self.tagView.textFiled.text = names
        }
        let navVC = GYZBaseNavigationVC(rootViewController:vc)
        
        self.present(navVC, animated: true, completion: nil)
    }
    //选择美食
    func goSelectGoodsVC(){
        let searchVC = JSLSearchShopVC()
        searchVC.isPublish = true
        searchVC.resultBlock = {[unowned self] (model) in
            self.currGoodsModel = model
            self.zuoBiaoView.textFiled.text = model.goods_name
        }
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    //选择分类
    func selectCategory(){
        if catrgoryList.count > 0 {
            UsefulPickerView.showSingleColPicker("选择笔记分类", data: categoryNameList, defaultSelectedIndex: selectCategoryIndex) {[unowned self] (index, value) in
                
                self.selectCategoryIndex = index
                self.categoryView.textFiled.text = self.categoryNameList[index]
            }
        }
    }
    ///打开相机
    func openCamera(){
        if selectImgs.count == kMaxSelectCount{
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
    
    ///打开相册
    func openPhotos(){
        
        let pickerController = DKImagePickerController()
        pickerController.maxSelectableCount = maxImgCount
        pickerController.sourceType = .photo
        
        weak var weakSelf = self
        
        pickerController.didSelectAssets = { (assets) in
            
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
    
}
extension JSLPublishVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        guard let image = info[picker.allowsEditing ? UIImagePickerController.InfoKey.editedImage : UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        picker.dismiss(animated: true) { [unowned self] in
            
            if self.selectImgs.count == kMaxSelectCount{
                MBProgressHUD.showAutoDismissHUD(message: "最多只能上传\(kMaxSelectCount)张图片")
                return
            }
            self.selectImgs.append(image)
            self.maxImgCount -= 1
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
    
}

