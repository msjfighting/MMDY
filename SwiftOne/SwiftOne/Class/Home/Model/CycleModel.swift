//
//  CycleModel.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/11.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
import HandyJSON
class CycleModel: NSObject,HandyJSON {
    var main_id : Int = 0
    var pic_url : String = ""
    var title : String = ""
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel.deserialize(from: room)!
        }
    }
    var anchor : AnchorModel?
    required override init() {}
}
