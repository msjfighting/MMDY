//
//  AnchorModel.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/10.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
import HandyJSON
class AnchorModel: HandyJSON {
    var room_id : Int = 0
    var vertical_src : String = ""
    // 0 : 电脑直播 1 : 手机直播
    var isVertical : Int = 0
    var room_name : String = ""
    var nickname : String = ""
    var online : Int = 0
    var anchor_city : String = ""
   required init() {}
}
