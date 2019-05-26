//
//  VerticalButton.swift
//  SwiftDanTang
//
//  Created by 品德信息 on 2017/8/25.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit

class VerticalButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //调整图片
        imageView?.x = 10
        imageView?.y = 10
        imageView?.width = self.width - 20
        imageView?.height = (imageView?.width)!
        //调整文字
        titleLabel?.x = 0
        titleLabel?.y = (imageView?.width)!
        titleLabel?.width = self.width
        titleLabel?.height = self.height - (self.titleLabel?.y)!
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
