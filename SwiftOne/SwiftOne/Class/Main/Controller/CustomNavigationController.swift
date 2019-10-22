//
//  CustomNavigationController.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/12.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 全屏手势 : 运行时机制
        // 获取系统手势
        guard let systemGes = interactivePopGestureRecognizer else {return}
        
         // 获取系统的手机监听view
        guard let gesView = systemGes.view else {return}
        
        // 获取系统手势的target&action
        let targets = systemGes.value(forKey: "_targets") as? [AnyObject]
        guard let targetObj = targets?.first else {return}
        guard let target = targetObj.value(forKey: "target") else {return}
        
        let action = Selector(("handleNavigationTransition:"))

        // 创建自己的手势,添加到事件监听时,使用上步中的traget&action
        let panGes = UIPanGestureRecognizer()
        panGes.addTarget(target, action: action)

        // 将手势添加到系统手势监听的view中
         gesView.addGestureRecognizer(panGes)
         self.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}
