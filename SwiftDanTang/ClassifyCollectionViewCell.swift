


//
//  ClassifyCollectionViewCell.swift
//  SwiftDanTang
//
//  Created by 品德信息 on 2017/8/30.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit

class ClassifyCollectionViewCell: UICollectionViewCell {
    
    var imageView:UIImageView?
    var titleLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    var model:GroupModel?{
     
        didSet{
            imageView?.kf.setImage(with: URL(string:(model?.icon_url)!))
            titleLabel?.text = model?.name
        }
    }
    
   
    fileprivate func initView(){
        imageView = UIImageView()
        imageView?.layer.cornerRadius = self.width / 2
        imageView?.layer.masksToBounds = true
        self.contentView.addSubview(imageView!)
        
        imageView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.height.equalTo(self.width)
        })
        
        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        titleLabel?.textAlignment = .center
        self.contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((imageView?.snp.bottom)!)
            make.width.equalTo(self.width)
            make.height.equalTo(20)
        })

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
