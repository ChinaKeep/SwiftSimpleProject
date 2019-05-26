//
//  UISegmentControlExt.swift
//  DanTang
//
//  Created by 品德信息 on 2017/8/22.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit

class UISegmentControlExt: UIView {

    var valueChange:((_ value:Int) -> ())?
    var font :UIFont?
    weak var selectButton = UIButton()
    weak var indicatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWithItems(items:[String]) {
        
        let indicatorView = UIView()
        indicatorView.backgroundColor = TXGlobalRedColor()
        indicatorView.height = 2
        indicatorView.y = self.height - 2
        self.indicatorView = indicatorView
        indicatorView.tag = -1
        
        let count  = items.count
        let width = frame.size.width/CGFloat(count)
        let height = frame.size.height
        
        for index in 0..<count{
            let button  = UIButton()
            button.height = height
            button.width = width
            button.x = CGFloat(index)*width
            button.tag = index
            button.setTitle(items[index], for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.setTitleColor(TXGlobalRedColor(), for: .disabled)
            button.addTarget(self, action: #selector(titlesClick(button:)), for: .touchUpInside)
            self.addSubview(button)
            
            if index == 0 {
                button.isEnabled = false
                selectButton = button
                indicatorView.width = button.width
                indicatorView.centerX = button.centerX
            }
            
        }
        self.addSubview(indicatorView)
    }
    
    @objc private func titlesClick(button:UIButton){
        selectButton?.isEnabled = true
        button.isEnabled = false
        selectButton = button
        UIView.animate(withDuration: 0.25) { 
            self.indicatorView?.width = (self.selectButton?.width)!
            self.indicatorView?.centerX = (self.selectButton?.centerX)!
        }
        if valueChange != nil {
            valueChange!(button.tag)
        }
    }
    
}
 
