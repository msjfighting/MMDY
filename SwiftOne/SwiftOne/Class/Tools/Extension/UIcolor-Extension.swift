//
//  UIcolor-Extension.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/9.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r:CGFloat, g:CGFloat, b:CGFloat){
        self.init(red:r/255.0, green: g/255.0, blue:b/255.0, alpha:1.0)
    }
}
