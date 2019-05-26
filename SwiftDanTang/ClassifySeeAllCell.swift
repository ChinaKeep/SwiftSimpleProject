
//
//  ClassifySeeAllCell.swift
//  SwiftDanTang
//
//  Created by 品德信息 on 2017/8/30.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit

class ClassifySeeAllCell: UITableViewCell {
    @IBOutlet weak var SubtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var placeholderButton: UIButton!
    @IBOutlet weak var bgImageView: UIImageView!
    
    var collection:ClassifySeeAllModel?{
        didSet{
            let url = collection?.cover_image_url
            bgImageView.kf.setImage(with: URL(string:url!)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                self.placeholderButton.isHidden = true
            }
            titleLabel.text = collection?.title
            SubtitleLabel.text = collection?.subtitle
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        bgImageView.layer.cornerRadius = 5.0
        bgImageView.layer.masksToBounds = true
    }
    
}
