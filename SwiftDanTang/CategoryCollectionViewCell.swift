

//
//  CategoryCollectionViewCell.swift
//  SwiftDanTang
//
//  Created by 品德信息 on 2017/8/29.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var name:String?{
        didSet{
            imageView.kf.setImage(with: URL(string:name!))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
