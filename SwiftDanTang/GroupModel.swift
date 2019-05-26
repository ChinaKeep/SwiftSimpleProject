//
//  GroupModel.swift
//  SwiftDanTang
//
//  Created by 品德信息 on 2017/8/29.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit

class GroupModel: NSObject {
    
    var group_id:Int?
    var icon_url:String?
    var id:Int?
    var items_count:Int?
    var name:String?
    var order:Int?
    var status:Int?
    
    init(dict:[String:AnyObject]) {
        super.init()
        group_id                = dict["group_id"]as? Int
        icon_url                = dict["icon_url"]as? String
        id                      = dict["id"]as? Int
        items_count             = dict["items_count"]as? Int
        name                    = dict["name"]as? String
        order                   = dict["order"]as? Int
        status                  = dict["status"]as? Int
    }
}
