//
//  MineVC.swift
//  DanTang
//
//  Created by 品德信息 on 2017/8/1.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit
import SVProgressHUD

class MineVC: TXBaseViewController,UITableViewDataSource,UITableViewDelegate {
   
    var cellCount = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    //创建tableView
    private func initTableView(){
        let tableView = UITableView()
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
    }
    
    private lazy var headerView:MineHeaderView = {
        let headerView = MineHeaderView()
        headerView.frame = CGRect(x:0,y:0,width:KScreenWidth,height:200)
        headerView.iconButton.addTarget(self, action: #selector(iconButtonClick), for: .touchUpInside)
        headerView.messageButton.addTarget(self, action: #selector(messageButtonClick), for: .touchUpInside)
        headerView.settingButton.addTarget(self, action: #selector(settingButtonClick), for: .touchUpInside)
        return headerView
    }()
    
    //MARK: -- 头部按钮点击 --
    func iconButtonClick()  {
        SVProgressHUD.showInfo(withStatus: "该跳登录了")
    }
    
    func messageButtonClick()  {
        SVProgressHUD.showInfo(withStatus: "该跳消息了")
    }
    
    func settingButtonClick() {
        SVProgressHUD.showInfo(withStatus: "该跳设置了")
    }
    
    private lazy var footerView:MineFooterView = {
        let footerView = MineFooterView(frame:CGRect(x:0,y:0,width:KScreenWidth,height:200))
       return footerView
    }()
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let choiceView = UISegmentControlExt(frame:CGRect(x:0,y:505,width:KScreenWidth,height:40))
        choiceView.initWithItems(items:["喜欢的商品","喜欢的专题"])
        choiceView.backgroundColor = UIColor.white
        choiceView.valueChange = { (value) -> () in
        }
        return choiceView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style:.default,reuseIdentifier:"cell")
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            var tempFrame = headerView.bgImageView.frame
            tempFrame.origin.y = offsetY
            tempFrame.size.height = 200 - offsetY
            headerView.bgImageView.frame = tempFrame
        }
    }
}
