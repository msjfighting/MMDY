//
//  BaseModel.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/11.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
import HandyJSON
class BaseModel: NSObject , HandyJSON{
    var tag_name : String = ""
    var icon_url : String = "home_header_normal"
    var small_icon_url : String = "home_header_normal"
    required override init() {}
}
