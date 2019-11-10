//
//  JSLMyFollowVC.swift
//  JSLogistics
//  我的关注
//  Created by gouyz on 2019/11/10.
//  Copyright © 2019 gouyz. All rights reserved.
//

import UIKit

private let myFollowCell = "myFollowCell"

class JSLMyFollowVC: GYZBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "粉丝列表"
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
        table.backgroundColor = kWhiteColor
        
        table.register(JSLMyFensiCell.classForCoder(), forCellReuseIdentifier: myFollowCell)
        
        return table
    }()
}
extension JSLMyFollowVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: myFollowCell) as! JSLMyFensiCell
        
        
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
        
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}

