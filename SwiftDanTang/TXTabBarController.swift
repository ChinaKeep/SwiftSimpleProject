//
//  TXTabBarController.swift
//  DanTang
//
//  Created by 品德信息 on 2017/8/1.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit

class TXTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBar = UITabBar.appearance()
        tabBar.tintColor = TXColor(r: 245, g: 90, b: 93, a: 1/0)
        addChildViewControllers()
    }
    
    func addChildViewControllers() {
        
    addChildViewController(childController:HomeVC() , title: "单糖", imaged: "TabBar_home_23x23_")
    addChildViewController(childController: ProductVC(), title: "单品", imaged: "TabBar_gift_23x23_")
    addChildViewController(childController: ClassifyVC(), title: "分类", imaged: "TabBar_category_23x23_")
    addChildViewController(childController: MineVC(), title: "我的", imaged: "TabBar_me_boy_23x23_")
    }

    func addChildViewController( childController: UIViewController,title: String,imaged:String) {
        
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imaged)
        childController.tabBarItem.selectedImage = UIImage(named:imaged+"selected")
        let nav = TXNavigationController(rootViewController:childController)
        addChildViewController(nav)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  }
