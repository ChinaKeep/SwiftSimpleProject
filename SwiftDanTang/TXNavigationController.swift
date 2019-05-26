//
//  TXNavigationController.swift
//  DanTang
//
//  Created by 品德信息 on 2017/8/1.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit

class TXNavigationController: UINavigationController {

    internal override class func initialize(){
        super.initialize()
        
        //设置导航标题
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = TXGlobalRedColor()
        navBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.systemFont(ofSize: 20)]
    }
    /**
     # 统一所有控制器导航栏左上角的返回按钮
     # 让所有的push进来的控制器，它的导航栏左上角的内容都一样
     # 能拦截所有的push操作
     - parameter viewController: 需要压栈的控制器
     - parameter animated: 是否动画
     */
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true;
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named:"checkUserType_backward_9x15_"),style:.plain,target:self,action:#selector(navigationBackClick))
            viewController.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        }
        super.pushViewController(viewController, animated: true)
    }
    
    //返回按钮
    func navigationBackClick()  {
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
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
