//
//  AmuseViewController.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/12.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

private let menuViewH : CGFloat = 200
class AmuseViewController: BaseAnchorViewController {
    
    fileprivate lazy var viewModel : AmuseViewModel = {
          let viewModel = AmuseViewModel()
          return viewModel
      }()
    
    fileprivate lazy var amuseMenuView : AmuseMenuView = {
        let amuseMenuView = AmuseMenuView.amuseMenuView()
        amuseMenuView.frame = CGRect(x: 0, y: -menuViewH, width: kScreenWidth, height: menuViewH)
        amuseMenuView.autoresizingMask = UIView.AutoresizingMask()
        return amuseMenuView;
    }()
}

extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(amuseMenuView)
        collectionView.contentInset = UIEdgeInsets(top: menuViewH, left: 0, bottom: 0, right: 0)
    }
}

extension AmuseViewController {
    override func baseLoadData() {
         baseViewModel = viewModel
         viewModel.requestAmuseData {
            self.collectionView.reloadData()
            var temp = self.viewModel.anchorGroup
            temp.removeFirst()
            self.amuseMenuView.groups = temp
            self.loadDataFinished()
        }
       }
}

