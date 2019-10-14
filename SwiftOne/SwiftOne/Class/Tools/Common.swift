//
//  Common.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/9.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
let IS_IPHONE_X = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false)
//状态栏高度
let kStatusBarH = UIApplication.shared.statusBarFrame.height;
let kNavigationBarH  = (kStatusBarH + 44)
let kTabbarH = (kStatusBarH == 44 ? 83 : 49)

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

let BaseURL : String = "http://capi.douyucdn.cn/api/v1/"

