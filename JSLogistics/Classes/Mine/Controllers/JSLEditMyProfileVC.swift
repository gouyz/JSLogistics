//
//  JSLEditMyProfileVC.swift
//  JSLogistics
//  编辑资料
//  Created by gouyz on 2019/11/4.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD
import DKImagePickerController

private let editMyProfileCell = "editMyProfileCell"
private let editMyProfilePhotoCell = "editMyProfilePhotoCell"
private let editMyProfilePhotoHeader = "editMyProfilePhotoHeader"

class JSLEditMyProfileVC: GYZBaseVC {
    
    /// 选择结果回调
    var resultBlock:(() -> Void)?
    
    let titleArr: [String] = ["头像","昵称","电话","生日","性别","个人签名","邮箱","所在地"]
    
    let sexNameArr:[String] = ["保密","男","女"]
    /// 选择头像
    var selectedHeader: UIImage?
    var selectedHeaderUrl: String = ""
    var imgUrls: String = ""
    var userInfoModel: JSLUserInfoModel?
    /// 图片列表
    var imgList: [JSLMyProfilePhotoModel] = [JSLMyProfilePhotoModel]()
    var selectPhotoCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "编辑资料"
        let rightBtn = UIButton(type: .custom)
        rightBtn.setTitle("保存", for: .normal)
        rightBtn.titleLabel?.font = k15Font
        rightBtn.setTitleColor(kGreenFontColor, for: .normal)
        rightBtn.frame = CGRect.init(x: 0, y: 0, width: kTitleHeight, height: kTitleHeight)
        rightBtn.addTarget(self, action: #selector(onClickRightBtn), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        
        self.view.backgroundColor = kWhiteColor
        
        initData()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorColor = kGrayLineColor
        table.backgroundColor = kBackgroundColor
        
        
        table.register(GYZMyProfileCell.classForCoder(), forCellReuseIdentifier: editMyProfileCell)
        table.register(JSLUploadPhotoCell.classForCoder(), forCellReuseIdentifier: editMyProfilePhotoCell)
        table.register(LHSGeneralHeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: editMyProfilePhotoHeader)
        
        return table
    }()
    // 保存
    @objc func onClickRightBtn(){
        if imgList.count > 0 {
            for (index,imgItem) in imgList.enumerated() {
                if imgItem.isUrl == "0" {
                    selectPhotoCount += 1
                    let imgParam: ImageFileUploadParam = ImageFileUploadParam()
                    imgParam.name = "image"
                    imgParam.fileName = "photo\(index).jpg"
                    imgParam.mimeType = "image/jpg"
                    imgParam.data = UIImage.jpegData(imgItem.img!)(compressionQuality: 0.5)!
                    
                    uploadImgFiles(imgsParam: [imgParam],index: index)
                }
                
            }
        }else{
            requestSaveProfile()
        }
    }
    
    func initData(){
        if let model = userInfoModel {
            selectedHeaderUrl = model.head_pic!
            for item in model.imgList {
                let imgModel = JSLMyProfilePhotoModel.init()
                imgModel.imgURL = item
                imgModel.isUrl = "1"
                imgList.append(imgModel)
            }
        }
    }
    
    /// 选择性别
    func showSelectSex(){
        UsefulPickerView.showSingleColPicker("选择性别", data: sexNameArr, defaultSelectedIndex: 0) {[unowned self] (index, value) in
            
            self.userInfoModel?.sex = value
            self.tableView.reloadData()
        }
    }
    /// 选择生日
    func showSelectBirthday(){
        UsefulPickerView.showDatePicker("选择生日") { [unowned self](date) in
            
            self.userInfoModel?.birthday = date.dateToStringWithFormat(format: "yyyy-MM-dd")
            self.tableView.reloadData()
        }
    }
    /// 选择所在城市
    func showSelectCity(){
        UsefulPickerView.showCitiesPicker("选择所在城市", defaultSelectedValues: ["江苏", "常州", "天宁区"]) {[unowned self] (selectedIndexs, selectedValues) in
            
            self.userInfoModel?.province = selectedValues[0]
            self.userInfoModel?.city = selectedValues[1]
            self.userInfoModel?.district = selectedValues[2]
            self.tableView.reloadData()
        }
    }
    /// 获取textField值
    @objc func textFieldDidChange(textField:UITextField){
        let tag = textField.tag
        if tag == 1{// 昵称
            userInfoModel?.nickname = textField.text
        }else if tag == 2{// 手机号
            userInfoModel?.mobile = textField.text
        }else if tag == 5{// 个性签名
            userInfoModel?.introduction = textField.text
        }else if tag == 6{// 邮箱
            userInfoModel?.email = textField.text
        }
    }
    /// 修改头像
    func goModifyHeader(){
        GYZOpenCameraPhotosTool.shareTool.choosePicture(self, editor: true, finished: { [unowned self] (image) in
            self.selectedHeader = image
            self.tableView.reloadData()
            let imgParam: ImageFileUploadParam = ImageFileUploadParam()
            imgParam.name = "image"
            imgParam.fileName = "header.jpg"
            imgParam.mimeType = "image/jpg"
            imgParam.data = UIImage.jpegData(image)(compressionQuality: 0.5)!
            self.uploadHeaderImgFiles(imgsParam: [imgParam])
        })
    }
    /// 上传头像图片
    ///
    /// - Parameter params: 参数
    func uploadHeaderImgFiles(imgsParam: [ImageFileUploadParam]){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        
        GYZNetWork.uploadImageRequest("user/upload_image", parameters: nil, uploadParam: imgsParam, success: { (response) in
            
            GYZLog(response)
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                weakSelf?.selectedHeaderUrl = response["url"].stringValue
                
            }else{
                weakSelf?.hud?.hide(animated: true)
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
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
                
                if index == (weakSelf?.selectPhotoCount)! - 1 {
                    weakSelf?.requestSaveProfile()
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
    // 精选照片
    func selecPhotos(){
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
        pickerController.sourceType = .photo
        
        weak var weakSelf = self
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            
            for item in assets {
                item.fetchFullScreenImage(completeBlock: { (image, info) in
                    let imgModel = JSLMyProfilePhotoModel.init()
                    imgModel.img = image
                    imgModel.isUrl = "0"
                    weakSelf?.imgList.insert(imgModel, at: 0)
                    weakSelf?.tableView.reloadData()
                })
            }
        }
        pickerController.modalPresentationStyle = .fullScreen
        self.present(pickerController, animated: true) {}
    }
    
    ///保存我的资料
    func requestSaveProfile(){
        if !GYZTool.checkNetWork() {
            return
        }
        weak var weakSelf = self
        
        for model in imgList {
            if model.isUrl == "1" {
                imgUrls += model.imgURL! + ","
            }
        }
        if imgUrls.hasSuffix(",") {
            imgUrls = imgUrls.subString(start: 0, length: imgUrls.count - 1)
        }

        let paramDic: [String:Any] = ["nickname":(userInfoModel?.nickname)!,"head_pic":selectedHeaderUrl,"user_id":userDefaults.string(forKey: "userId") ?? "","img":imgUrls,"birthday":(userInfoModel?.birthday)!,"sex":(userInfoModel?.sex)!,"introduction":(userInfoModel?.introduction)!,"email":(userInfoModel?.email)!,"province":(userInfoModel?.province)!,"city":(userInfoModel?.city)!,"district":(userInfoModel?.district)!]

        GYZNetWork.requestNetwork("user/editUserInfo", parameters: paramDic,  success: { (response) in

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

extension JSLEditMyProfileVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return titleArr.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: editMyProfileCell) as! GYZMyProfileCell
            
            cell.userImgView.isHidden = true
            cell.textFiled.isEnabled = true
            cell.rightIconView.isHidden = true
            cell.nameLab.text = titleArr[indexPath.row]
            
            cell.textFiled.tag = indexPath.row
            cell.textFiled.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
            
            if indexPath.row == 0 {
                cell.userImgView.isHidden = false
                cell.textFiled.isEnabled = false
                cell.rightIconView.isHidden = false
                if selectedHeader != nil {
                    cell.userImgView.image = selectedHeader
                }else{
                    cell.userImgView.kf.setImage(with: URL.init(string: (userInfoModel?.head_pic)!))
                }
            }else if indexPath.row == 1{
                cell.textFiled.text = userInfoModel?.nickname
            }else if indexPath.row == 2{
                cell.textFiled.text = userInfoModel?.mobile
            }else if indexPath.row == 3{
                cell.textFiled.isEnabled = false
                cell.rightIconView.isHidden = false
                cell.textFiled.text = userInfoModel?.birthday
            }else if indexPath.row == 4{
                cell.textFiled.isEnabled = false
                cell.rightIconView.isHidden = false
                cell.textFiled.text = userInfoModel?.sex
            }else if indexPath.row == 5{
                cell.textFiled.text = userInfoModel?.introduction
            }else if indexPath.row == 6{
                cell.textFiled.text = userInfoModel?.email
            }else if indexPath.row == 7{
                cell.textFiled.isEnabled = false
                cell.rightIconView.isHidden = false
                cell.textFiled.text = "\((userInfoModel?.province)!)\((userInfoModel?.city)!)\((userInfoModel?.district)!)"
            }
            
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: editMyProfilePhotoCell) as! JSLUploadPhotoCell
            cell.dataModel = imgList
            cell.didSelectItemBlock = {[unowned self] (index) in
                if index == self.imgList.count {
                    self.selecPhotos()
                }
            }
            cell.didDeleteItemBlock = {[unowned self] (index) in
                self.imgList.remove(at: index)
                self.tableView.reloadData()
            }
            
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: editMyProfilePhotoHeader) as! LHSGeneralHeaderView
            
            headerView.nameLab.text = "精选照片"
            return headerView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {// 选择性别
            showSelectSex()
        }else if indexPath.row == 3 {// 选择生日
            showSelectBirthday()
        }else if indexPath.row == 7 {// 选择城市
            showSelectCity()
        }else if indexPath.row == 0 {// 选择头像
            goModifyHeader()
        }
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 64
            }
            return 50
        }
        return floor((kScreenWidth - kMargin * 5)/4) + 20
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return kTitleHeight
        }
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return kMargin
        }
        return 0.00001
    }
    
}
extension JSLEditMyProfileVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        guard let image = info[picker.allowsEditing ? UIImagePickerController.InfoKey.editedImage : UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        picker.dismiss(animated: true) { [unowned self] in
            
            let imgModel = JSLMyProfilePhotoModel.init()
            imgModel.img = image
            imgModel.isUrl = "0"
            self.imgList.insert(imgModel, at: 0)
            self.tableView.reloadData()
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        picker.dismiss(animated: true, completion: nil)
        
    }
}
