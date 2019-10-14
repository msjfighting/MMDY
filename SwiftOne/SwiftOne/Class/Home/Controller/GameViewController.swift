//
//  GameViewController.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/11.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenWidth - 4 * kItemMargin)/3
private let kItemH = kItemW * 6 / 5
private let kHeaderH : CGFloat = 50
private let kCellH : CGFloat = 100
private let kGameViewH : CGFloat = 90

class GameViewController: BaseViewController {
    fileprivate lazy var gameViewModel : GameViewModel = {
          let gameViewModel = GameViewModel()
          return gameViewModel
    }()
    fileprivate lazy var collectionView : UICollectionView = {
       [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kCellH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: "CollectionGameCell")
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        return collectionView
    }()
    
    fileprivate lazy var topHeaderView : HeaderView = {
        let topHeaderView = HeaderView.headerView()
        topHeaderView.frame = CGRect(x: 0, y: -(kHeaderH + kGameViewH), width: kScreenWidth, height: kHeaderH)
        topHeaderView.moreBtn.isHidden = true
        topHeaderView.icon.image = UIImage(named: "Img_orange")
        topHeaderView.title.text = "常用"
        return topHeaderView
    }()
    private lazy var gameView : RecommendGameView = {
           let gameView = RecommendGameView.recommendGameView()
           gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
            // 设置空间不随着父控件拉伸而拉伸
          gameView.autoresizingMask = UIView.AutoresizingMask()
           return gameView
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

extension GameViewController {
    override func setupUI() {
        contentView = collectionView
        view.addSubview(collectionView)
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kHeaderH + kGameViewH, left: 0, bottom: 0, right: 0)
        super.setupUI()
    }
}
extension GameViewController {
    private func loadData() {
        gameViewModel.requestGameData {
            self.collectionView.reloadData()
            let temp = self.gameViewModel.anchorGroup[0..<5]
            self.gameView.groups = Array(temp)
            self.loadDataFinished()
        }
    }
}

extension GameViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.anchorGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionGameCell", for: indexPath) as! CollectionGameCell
        cell.model = gameViewModel.anchorGroup[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as!HeaderView
        header.moreBtn.isHidden = true
        header.icon.image = UIImage(named: "Img_orange")
        header.title.text = "全部"
       
        return header;
    }

}
