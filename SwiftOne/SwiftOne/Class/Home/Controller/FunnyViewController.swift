//
//  FunnyViewController.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/12.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

class FunnyViewController: BaseAnchorViewController {
    fileprivate lazy var viewModel : FunnyViewModel = FunnyViewModel()
}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = UIColor.white
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyViewController {
    override func baseLoadData() {
        baseViewModel = viewModel
        viewModel.requestFunnyData {
            self.collectionView.reloadData()
             self.loadDataFinished()
        }
    }
}
