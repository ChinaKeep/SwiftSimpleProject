//
//  MineFooterView.swift
//  SwiftDanTang
//
//  Created by 品德信息 on 2017/10/9.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit
import SVProgressHUD

class MineFooterView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        addSubview(meBlankButton)
        addSubview(messageLabel)
        
        meBlankButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width:50,height:50))
            make.center.equalTo(self.center)
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(meBlankButton.snp.bottom).offset(kMargin)
            make.left.right.equalTo(self)
        }
    }
    //懒加载
    private lazy var meBlankButton:UIButton = {
        let meBlankButton = UIButton()
        meBlankButton.setTitleColor(TXColor(r: 200, g: 200, b: 200, a: 1.0), for: .normal)
        meBlankButton.width = 100
        meBlankButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        meBlankButton.setImage(UIImage(named:"Me_blank_50x50_"), for: .normal)
        meBlankButton.addTarget(self, action: #selector(footerViewButtonClick), for: .touchUpInside)
        meBlankButton.imageView?.sizeToFit()
       return meBlankButton
    }()
    
    private lazy var messageLabel:UILabel = {
        let messageLabel = UILabel()
        messageLabel.text = "登录以享受功能"
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.textColor = TXColor(r: 200, g: 200, b: 200, a: 1.0)
        return messageLabel
    }()
    
    func footerViewButtonClick()  {
        SVProgressHUD.showInfo(withStatus: "该登录了")
    }
}
