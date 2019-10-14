//
//  RecommendViewController.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/9.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenWidth * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    fileprivate lazy var viewModel : RecommendViewModel = {
        let viewModel = RecommendViewModel()
        return viewModel
    }()
    fileprivate lazy var cycleView : RecommendcycleView = {
        let cycleView = RecommendcycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH - kGameViewH, width: kScreenWidth, height: kCycleViewH)
          // 设置空间不随着父控件拉伸而拉伸
        cycleView.autoresizingMask = UIView.AutoresizingMask()
        return cycleView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
         // 设置空间不随着父控件拉伸而拉伸
       gameView.autoresizingMask = UIView.AutoresizingMask()
        return gameView
    }()

}

extension RecommendViewController {
    override func setupUI() {
        super.setupUI()
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: "CollectionPrettyCell")
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

extension RecommendViewController {
    override func baseLoadData() {
        baseViewModel = viewModel
        viewModel.requestData{
           self.collectionView.reloadData()
           var groups = self.viewModel.anchorGroup
           groups.remove(at: 0)
           groups.remove(at: 0)
          
           let more = AnchorGroup()
           more.tag_name = "更多"
           more.icon_url = "home_more_btn"
           more.small_icon_url = "home_more_btn"
           groups.append(more)
           self.gameView.groups = groups
           self.loadDataFinished()
       }
       
       viewModel.requestCycleData {
           self.cycleView.cycleDatas = self.viewModel.cycleDatas
       }
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout {
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = viewModel.anchorGroup[indexPath.section]
        let model : AnchorModel = group.anchors[indexPath.item]
        
        let cell : CollectionBaseCell!
        if indexPath.section == 1 {
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionPrettyCell", for: indexPath) as! CollectionPrettyCell
        }else{
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionNormalCell", for: indexPath) as! UICollectionNormalCell
        }
        cell.model = model
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }

}

