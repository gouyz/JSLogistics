//
//  JSLMyConmentListVC.swift
//  JSLogistics
//  我的评价列表
//  Created by gouyz on 2019/10/30.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit
import JXSegmentedView
import MBProgressHUD

private let myConmentListCartCell = "myConmentListCartCell"

class JSLMyConmentListVC: GYZBaseVC {
    
    weak var naviController: UINavigationController?
    /// 1未评价2已评价
    var type:Int = 1
    var currPage : Int = 0
    /// 最后一页
    var lastPage: Int = 1
    var dataList: [JSLGoodsOrderModel] = [JSLGoodsOrderModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        requestOrderList()
    }
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = kBackgroundColor
        // 设置大概高度
        table.estimatedRowHeight = 190
        // 设置行高为自动适配
        table.rowHeight = UITableView.automaticDimension
        
        table.register(JSLCartOrderListCell.classForCoder(), forCellReuseIdentifier: myConmentListCartCell)
        
        weak var weakSelf = self
        ///添加下拉刷新
        GYZTool.addPullRefresh(scorllView: table, pullRefreshCallBack: {
            weakSelf?.refresh()
        })
        ///添加上拉加载更多
        GYZTool.addLoadMore(scorllView: table, loadMoreCallBack: {
            weakSelf?.loadMore()
        })
        
        return table
    }()
    ///获取订单数据
    func requestOrderList(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        showLoadingView()
        
        GYZNetWork.requestNetwork("user/orderComment",parameters: ["page":currPage,"user_id":userDefaults.string(forKey: "userId") ?? "","type":type],  success: { (response) in
            
            weakSelf?.closeRefresh()
            weakSelf?.hiddenLoadingView()
            GYZLog(response)
            
            if response["status"].intValue == kQuestSuccessTag{//请求成功
                weakSelf?.lastPage = response["result"]["page_count"].intValue
                guard let data = response["result"]["orderList"].array else { return }
                for item in data{
                    guard let itemInfo = item.dictionaryObject else { return }
                    let model = JSLGoodsOrderModel.init(dict: itemInfo)
                    
                    weakSelf?.dataList.append(model)
                }
                weakSelf?.tableView.reloadData()
                if weakSelf?.dataList.count > 0{
                    weakSelf?.hiddenEmptyView()
                }else{
                    weakSelf?.showEmptyView(content: "暂无订单，请点击重新加载", reload: {
                        weakSelf?.hiddenEmptyView()
                        weakSelf?.refresh()
                    })
                }
                
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["msg"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.closeRefresh()
            weakSelf?.hiddenLoadingView()
            GYZLog(error)
            
            //第一次加载失败，显示加载错误页面
            if weakSelf?.currPage == 0{
                weakSelf?.showEmptyView(content: "加载失败，请点击重新加载", reload: {
                    weakSelf?.hiddenEmptyView()
                    weakSelf?.refresh()
                })
            }
            
        })
    }
    
    // MARK: - 上拉加载更多/下拉刷新
    /// 下拉刷新
    func refresh(){
        if currPage == lastPage - 1 {
            GYZTool.resetNoMoreData(scorllView: tableView)
        }
        currPage = 0
        dataList.removeAll()
        tableView.reloadData()
        requestOrderList()
    }
    
    /// 上拉加载更多
    func loadMore(){
        if currPage == lastPage - 1 {
            GYZTool.noMoreData(scorllView: tableView)
            return
        }
        currPage += 1
        requestOrderList()
    }
    
    /// 关闭上拉/下拉刷新
    func closeRefresh(){
        if tableView.mj_header.isRefreshing{//下拉刷新
            GYZTool.endRefresh(scorllView: tableView)
        }else if tableView.mj_footer.isRefreshing{//上拉加载更多
            GYZTool.endLoadMore(scorllView: tableView)
        }
    }
    /// 订单详情
    func goDetailVC(index: Int){
        let vc = JSLCartOrderDetailVC()
        vc.orderType = "1"
        vc.orderId = dataList[index].order_id!
        self.naviController?.pushViewController(vc, animated: true)
    }
    /// 操作
    @objc func onClickedOperator(sender:UIButton){
        let tag = sender.tag
        let model = dataList[tag]
        if model.order_status == "4" {// 已评价
            goSeeConmentVC(index: tag)
        }else if model.order_status == "2" {
            goConmentVC(index: tag)
        }
    }
    // 立即评价
    func goConmentVC(index: Int){
        let vc = JSLOrderConmentVC()
        vc.orderId = dataList[index].order_id!
        vc.goodsImgUrl = (dataList[index].goodsInfo?.original_img)!
        vc.resultBlock = {[unowned self] () in
            self.refresh()
        }
        self.naviController?.pushViewController(vc, animated: true)
    }
    // 查看评价
    func goSeeConmentVC(index: Int){
        let vc = JSLConmentDetailVC()
        vc.orderId = dataList[index].order_id!
        self.naviController?.pushViewController(vc, animated: true)
    }
}
extension JSLMyConmentListVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: myConmentListCartCell) as! JSLCartOrderListCell
        
        cell.dataModel = dataList[indexPath.row]
        
        if dataList[indexPath.row].order_status == "4" {
            cell.operatorBtn.isHidden = false
            cell.operatorBtn.setTitle("查看评价", for: .normal)
            cell.operatorBtn.snp.updateConstraints { (make) in
                make.width.equalTo(80)
                make.height.equalTo(30)
            }
        }
        cell.operatorBtn.tag = indexPath.row
        cell.operatorBtn.addTarget(self, action: #selector(onClickedOperator(sender:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goDetailVC(index: indexPath.row)
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.00001
    }
}
extension JSLMyConmentListVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self.view
    }
    func listDidAppear() {
        
    }
}
