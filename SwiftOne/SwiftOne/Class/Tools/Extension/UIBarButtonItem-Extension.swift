//
//  UIBarButtonItem-Extension.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/9.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func createItem(imageName: String, highName: String,size: CGSize) -> UIBarButtonItem {
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: imageName),for: .normal)
         btn.setImage(UIImage.init(named: highName),for: .highlighted)
        
        btn.frame = CGRect.init(origin: CGPoint.zero, size: size);
        return UIBarButtonItem.init(customView: btn)
    }
    
    // 便利构造函数 1> convenience开头, 2> 在构造函数中必须明确调用一个设计的构造函数(self)
   convenience init(imageName: String, highName: String = "",size: CGSize = CGSize.zero) {
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: imageName),for: .normal)
        if highName != ""{
             btn.setImage(UIImage.init(named: highName),for: .highlighted)
        }

        if size != CGSize.zero{
            btn.frame = CGRect.init(origin: CGPoint.zero, size: size)
        }
    
        self.init(customView: btn)
    }
}
