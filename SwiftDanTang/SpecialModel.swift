//
//  SpecialModel.swift
//  SwiftDanTang
//
//  Created by 品德信息 on 2017/8/28.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit

class SpecialModel: NSObject {

    var banner_image_url: String?
    var cover_image_url:  String?
    var created_at:       Int?
    var id:               Int?
    var posts_count:      Int?
    var status:           Int?
    var subtitle:         String?
    var title:            String?
    var updated_at:       Int?
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        banner_image_url    = dict["banner_image_url"] as? String
        cover_image_url     = dict["cover_image_url"] as? String
        created_at          = dict["created_at"]as?Int
        id                  = dict["id"]as?Int
        posts_count         = dict["posts_count"] as?Int
        status              = dict["status"]as?Int
        subtitle            = dict["subtitle"]as?String
        title               = dict["title"]as?String
        updated_at          = dict["updated_at"]as?Int
    }
}
