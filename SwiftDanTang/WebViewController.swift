//
//  WebViewController.swift
//  DanTang
//
//  Created by 品德信息 on 2017/8/18.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit
import SVProgressHUD

class WebViewController: TXBaseViewController ,UIWebViewDelegate{

    var webView = UIWebView()
    var url = String()
    var titleString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configToolBar()
        webView = UIWebView()
        webView.frame = view.bounds
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        let request = URLRequest(url:URL(string:url)!)
        webView.loadRequest(request)
        view.addSubview(webView)
        
        }
    
    func configToolBar() {
        
        let backItem = UIBarButtonItem(image:UIImage(named:"checkUserType_backward_9x15_"),style:.plain,target:self ,action:#selector(backButtonClick))
        //    public convenience init(image: UIImage?, style: UIBarButtonItemStyle, target: Any?, action: Selector?)
        //    public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, target: Any?, action: Selector?)

        let flexItem0 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let flexItem1 = UIBarButtonItem(barButtonSystemItem: .fixedSpace,target:nil,action:nil)
        let forwardItem = UIBarButtonItem(image:UIImage(named:"Category_PostCollectionSeeAll_nightMode_5x8_"),style:.plain,target:nil,action:nil)
        
        self.setToolbarItems([backItem,flexItem0,forwardItem,flexItem1], animated: true)
    }

    //MARK:--webView的方法
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        SVProgressHUD.showInfo(withStatus: "正在加载中。。。")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.showError(withStatus: error.localizedDescription)
    }
    
    //MARK:--- button Action
    func backButtonClick() {
        if self.webView.canGoBack {
            self.webView.goBack()
        }
    }
}
