//
//  ClassifyContentVC.swift
//  SwiftDanTang
//
//  Created by 品德信息 on 2017/9/4.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit
fileprivate let cellIdentifier = "cellIdentifier"

class ClassifyContentVC: TXBaseViewController,UITableViewDelegate,UITableViewDataSource {

    var id = NSInteger()
    var tableView = UITableView()
    var datas = [HomeModel]()
    //专题集合
    var type = ClassifyContentVCType.ClassifyProject
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化tableView
        self.initContentView()
        self.requestData()
    }
    //MARK: - init方法 -
    private func initContentView() {
        
        tableView = UITableView(frame:CGRect(x:0,y:0,width:KScreenWidth,height:KScreenHeight),style:.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = TXGlobalColor()
        view.addSubview(tableView)
    }
    func requestData(){
        weak var weakSelf = self
        switch type {
        case .ClassifyProject:
            let url = BASE_URL + "v1/collections/\(id)/posts"
            let params = ["gender":1,
                          "generation":1,
                            "limit":20,
                            "offset":0]
            NetworkTool.shared.get(url: url, parms: params, finished: { (success, result, error) in
                if let data = result?["data"].dictionary{
                    if let postsData = data["posts"]?.arrayObject{
                        var posts = [HomeModel]()
                        for item in postsData{
                            let post = HomeModel(dict:item as! [String : AnyObject])
                            posts.append(post)
                        }
                        self.datas = posts
                    }
                }
                weakSelf?.tableView.reloadData()
            })
            break
        case .ClassifyOthers:
            break
        }
    }
    
    
    //MARK: -- tableView Delegate  DataSource --
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell  = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? HomeCell
        if cell == nil {
            cell = HomeCell(style:.default,reuseIdentifier:cellIdentifier)
        }
        cell?.homeModel = self.datas[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = datas[indexPath.row]
        let vc = WebViewController()
        vc.url = model.content_url!
        vc.title = "攻略详情"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
