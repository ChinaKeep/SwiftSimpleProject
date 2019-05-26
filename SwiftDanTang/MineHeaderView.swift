//
//  MineHeaderView.swift
//  SwiftDanTang
//
//  Created by 品德信息 on 2017/10/9.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit

class MineHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //初始化UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        //添加子控件
        addSubview(bgImageView)
        addSubview(settingButton)
        addSubview(messageButton)
        addSubview(iconButton)
        addSubview(nameLabel)
        //布局
        bgImageView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.top.equalTo(-20)
        }
        settingButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width:44,height:44))
            make.right.equalTo(self)
            make.top.equalTo(0)
        }
        messageButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width:44,height:44))
            make.left.equalTo(self)
            make.top.equalTo(settingButton.snp.top)
        }
        iconButton.snp.makeConstraints { (make) in
         make.centerX.equalTo(KScreenWidth * 0.5)
            make.size.equalTo(CGSize(width:75,height:75))
            make.bottom.equalTo(nameLabel.snp.top).offset(-kMargin)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-3 * kMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(2 * kMargin)
        }
    }
    

    ///懒加载 创建背景图片
    lazy var bgImageView:UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.image = UIImage(named:"Me_ProfileBackground")
        return bgImageView
    }()
    
    /// 懒加载 创建左上角的消息按钮
    lazy var messageButton :UIButton = {
        let messageButton  = UIButton()
        messageButton.setImage(UIImage(named:"Me_message_20x20_"), for: .normal)
       return messageButton
    }()
    /// 懒加载 创建设置按钮
    lazy var settingButton :UIButton = {
        let setttingButton = UIButton()
        setttingButton.setImage(UIImage(named:"Me_settings_20x20_"), for: .normal)
        return setttingButton
    }()
    /// 懒加载 创建头像按钮
    lazy var iconButton : UIButton = {
       let iconButton = UIButton()
        iconButton.setBackgroundImage(UIImage(named:"Me_AvatarPlaceholder_75x75_"), for: .normal)
        iconButton.layer.cornerRadius = iconButton.width * 0.5
        iconButton.layer.masksToBounds = true
        return iconButton
    }()
    
    ///懒加载 创建昵称标签
    private lazy var nameLabel:UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "hrscy"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 15.0)
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
}
