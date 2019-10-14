//
//  NSDate-Extension.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/10.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
extension NSDate {
    class func getCurrentTime() -> String {
        let now = NSDate()
        let interval = Int(now.timeIntervalSince1970)
        return "\(interval)"
    }
}
