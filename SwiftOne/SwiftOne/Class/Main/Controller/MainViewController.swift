//
//  MainViewController.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/9.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC(stroyName: "Home")
        addChildVC(stroyName: "Live")
        addChildVC(stroyName: "Fellow")
        addChildVC(stroyName: "Profile")
    }
    private func addChildVC(stroyName: String){
        let childVc = UIStoryboard.init(name: stroyName, bundle: nil).instantiateInitialViewController()!;
        addChild(childVc)
    }
}
