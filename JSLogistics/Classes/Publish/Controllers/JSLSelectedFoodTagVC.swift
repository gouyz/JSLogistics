//
//  JSLSelectedFoodTagVC.swift
//  JSLogistics
//  美食标签
//  Created by gouyz on 2019/11/5.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import MBProgressHUD


private let selectedFoodTagCell = "selectedFoodTagCell"
private let selectedFoodTagHeader = "selectedFoodTagHeader"
private let selectedFoodTagSearchCell = "selectedFoodTagSearchCell"

class JSLSelectedFoodTagVC: GYZBaseVC {
    
    var isSearchResult: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
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
    
    /// 取消搜索
    @objc func cancleSearchClick(){
        searchBar.resignFirstResponder()
        
        self.dismiss(animated: false, completion: nil)
    }
    
    ///保存选择城市信息
    func saveSelectCityInfo(city: FSCityListModel){
        let model = NSKeyedArchiver.archivedData(withRootObject: city)
        userDefaults.set(model, forKey: CURRCITYINFO)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
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
        tableView.reloadData()
//        searchCityData(searchTxt: searchBar.text!)
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
            return 12
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSearchResult {
            let cell = tableView.dequeueReusableCell(withIdentifier: selectedFoodTagSearchCell) as! GYZLabArrowCell
            
            cell.rightIconView.isHidden = true
            cell.nameLab.text = "结果"
            cell.nameLab.textColor = kGaryFontColor
            
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: selectedFoodTagCell) as! JSLSearchHotCell
            
            cell.tagsView.removeAllTags()
            cell.tagsView.addTags(["火锅/自助","520我要吃","元气端午","日韩料理","欢乐六一去哪儿","西餐"])
            
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
        
    }
    
}
