//
//  JSLSelectedFoodTagVC.swift
//  JSLogistics
//  美食标签
//  Created by gouyz on 2019/11/5.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD
import TTGTagCollectionView


private let selectedFoodTagCell = "selectedFoodTagCell"
private let selectedFoodTagHeader = "selectedFoodTagHeader"
private let selectedFoodTagSearchCell = "selectedFoodTagSearchCell"

class JSLSelectedFoodTagVC: GYZBaseVC {
    
    /// 选择结果回调
    var resultBlock:((_ tagNames: String) -> Void)?
    
    var isSearchResult: Bool = false
    
    /// 热门标签
    var hotTagList:[String] = [String]()
    /// 历史标签
    var historyTagList:[String] = [String]()
    /// 当前选择标签
    var currTagList:[String] = [String]()
    
    /// 搜索 内容
    var searchContent: String = ""
    // 搜索数据
    var dataList: [JSLGoodsCategoryModel] = [JSLGoodsCategoryModel]()
    var isHas: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        if let tags = userDefaults.stringArray(forKey: publishTagsData) {
            historyTagList = tags
        }
        requestHotTagsList()
    }
    func setupUI(){
        
        navigationItem.titleView = searchBar
        /// 解决iOS11中UISearchBar高度变大
        if #available(iOS 11.0, *) {
            searchBar.heightAnchor.constraint(equalToConstant: kTitleHeight).isActive = true
        }
        
        let btn = UIButton(type: .custom)
        btn.setTitle("取消", for: .normal)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        btn.frame = CGRect.init(x: 0, y: 0, width: kTitleHeight, height: kTitleHeight)
        btn.addTarget(self, action: #selector(cancleSearchClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: btn)
    }
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = kWhiteColor
        
        // 设置大概高度
        table.estimatedRowHeight = 100
        // 设置行高为自动适配
        table.rowHeight = UITableView.automaticDimension
        
        table.register(JSLSearchHotCell.classForCoder(), forCellReuseIdentifier: selectedFoodTagCell)
        table.register(GYZLabArrowCell.classForCoder(), forCellReuseIdentifier: selectedFoodTagSearchCell)
        table.register(LHSGeneralHeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: selectedFoodTagHeader)
        
        return table
    }()
    /// 搜索框
        lazy var searchBar : UISearchBar = {
            let search = UISearchBar()
            
            search.placeholder = "添加美食标签"
            search.delegate = self
            //显示输入光标
            search.tintColor = kHeightGaryFontColor
            /// 搜索框背景色
            if #available(iOS 13.0, *){
                search.searchTextField.backgroundColor = kGrayBackGroundColor
            }else{
                if let textfiled = search.subviews.first?.subviews.last as? UITextField {
                    textfiled.backgroundColor = kGrayBackGroundColor
                }
            }
            //弹出键盘
    //        search.becomeFirstResponder()
            
            return search
        }()
    
    ///获取热门标签数据
    func requestHotTagsList(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("index/getTagWords",parameters: nil,method :.get,  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].array else { return }
                for item in data{
                    weakSelf?.hotTagList.append(item.stringValue)
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
    /// 取消搜索
    @objc func cancleSearchClick(){
        searchBar.resignFirstResponder()
        if resultBlock != nil {
            var names: String = ""
            if currTagList.count > 0 {
                for item in currTagList {
                    names += item + ","
                }
                names = names.subString(start: 0, length: names.count - 1)
                userDefaults.set(currTagList, forKey: publishTagsData)
            }
            resultBlock!(names)
        }
        self.dismiss(animated: false, completion: nil)
    }
    
    ///获取搜索标签数据
    func requestSearchTagsList(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("publish/searchTag",parameters: ["keywords":searchContent],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                guard let data = response["result"].array else { return }
                
                for item in data{
                    guard let itemInfo = item.dictionaryObject else { return }
                    let model = JSLGoodsCategoryModel.init(dict: itemInfo)
                    weakSelf?.dataList.append(model)
                    
                    if model.name == weakSelf?.searchContent {
                        weakSelf?.isHas = true
                    }
                }
                if !(weakSelf?.isHas)! {
                    let model = JSLGoodsCategoryModel.init(dict: ["name":weakSelf?.searchContent as Any])
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
    
    ///添加标签数据
    func requestAddTags(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("publish/addTag",parameters: ["name":searchContent],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                weakSelf?.cancleSearchClick()
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
            
        })
    }
}
extension JSLSelectedFoodTagVC: UISearchBarDelegate{
    ///mark - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        if searchBar.text!.isEmpty {
            MBProgressHUD.showAutoDismissHUD(message: "请输入搜索内容")
            return
        }
        isSearchResult = true
        self.searchContent = searchBar.text ?? ""
        requestSearchTagsList()
    }
    /// 文本改变会调用该方法（包含clear文本）
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            isSearchResult = false
            tableView.reloadData()
        }
    }
}
extension JSLSelectedFoodTagVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearchResult {
            return 1
        }
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearchResult {
            return dataList.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSearchResult {
            let cell = tableView.dequeueReusableCell(withIdentifier: selectedFoodTagSearchCell) as! GYZLabArrowCell
            
            cell.rightIconView.isHidden = true
            cell.nameLab.text = dataList[indexPath.row].name
            cell.nameLab.textColor = kGaryFontColor
            
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: selectedFoodTagCell) as! JSLSearchHotCell
            
            cell.tagsView.removeAllTags()
            
            cell.tagsView.tag = indexPath.section
            cell.tagsView.delegate = self
            if indexPath.section == 1 { // 热门
                cell.tagsView.addTags(hotTagList)
                for item in currTagList {
                    if hotTagList.contains(item) {
                        cell.tagsView.setTagAt(UInt(hotTagList.firstIndex(of: item)!), selected: true)
                    }
                }
            }else{
                cell.tagsView.addTags(historyTagList)
                for item in currTagList {
                    if historyTagList.contains(item) {
                        cell.tagsView.setTagAt(UInt(historyTagList.firstIndex(of: item)!), selected: true)
                    }
                }
            }
            
            cell.tagsView.preferredMaxLayoutWidth = kScreenWidth - kMargin * 2
            
            //必须调用,不然高度计算不准确
            cell.tagsView.reload()
            
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if !isSearchResult {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: selectedFoodTagHeader) as! LHSGeneralHeaderView
            
            headerView.lineView.isHidden = false
            if section == 0 {
                headerView.nameLab.text = "最近用过的标签"
            }else{
                headerView.nameLab.text = "热门搜索"
            }
            return headerView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isSearchResult {
            return 0.00001
        }
        return kTitleHeight
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearchResult {
            currTagList.append(dataList[indexPath.row].name!)
            if isHas {
                cancleSearchClick()
            }else{
                requestAddTags()
            }
        }
    }
    
}

extension JSLSelectedFoodTagVC: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
        
        if selected {
            if !currTagList.contains(tagText) {
                currTagList.append(tagText)
            }
        }else{
            for (index,item) in currTagList.enumerated() {
                if item == tagText {
                    currTagList.remove(at: index)
                    break
                }
            }
        }
        tableView.reloadData()
    }
}
