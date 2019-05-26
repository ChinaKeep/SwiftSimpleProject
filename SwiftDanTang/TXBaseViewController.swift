//
//  TXBaseViewController.swift
//  DanTang
//
//  Created by 品德信息 on 2017/8/1.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture

class TXBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.colorWithHexString(hex: "#f5f5f5")
        navigationController?.fd_prefersNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
   
}
