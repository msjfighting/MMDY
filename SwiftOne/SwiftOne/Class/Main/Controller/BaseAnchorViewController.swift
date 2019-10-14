//
//  BaseAnchorViewController.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/12.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit


let kBaseItemMargin : CGFloat = 10
let kNormalItemW = (kScreenWidth - 3 * kBaseItemMargin)/2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3
let kBaseHeaderH : CGFloat = 50

class BaseAnchorViewController: BaseViewController {
    // 子类赋值
     var baseViewModel : BaseViewModel!
    
     lazy var collectionView : UICollectionView = {
        [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kBaseItemMargin
        
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kBaseHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kBaseItemMargin, bottom: 0, right: kBaseItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "UICollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: "UICollectionNormalCell")
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")

        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        baseLoadData()
    }

}

extension BaseAnchorViewController {
    override func setupUI() {
         contentView = collectionView
         view.addSubview(collectionView)
         super.setupUI()
       }
}
extension BaseAnchorViewController {
    @objc func baseLoadData() {}
}

extension BaseAnchorViewController :UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseViewModel.anchorGroup.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = baseViewModel.anchorGroup[section]
        return group.anchors.count
    }
    
  @objc func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionNormalCell", for: indexPath) as! UICollectionNormalCell
        let group = baseViewModel.anchorGroup[indexPath.section]
        let model : AnchorModel = group.anchors[indexPath.item]
        cell.model = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as!HeaderView
        header.group = baseViewModel.anchorGroup[indexPath.section]
        return header
    }

}

extension BaseAnchorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let group = baseViewModel.anchorGroup[indexPath.section]
        let model : AnchorModel = group.anchors[indexPath.item]
        model.isVertical == 0 ? presentShowRoom() : pushMoramlRoom()
    }
    
    private func presentShowRoom() {
        let showRoomVc = RoomShowViewController()
        showRoomVc.modalPresentationStyle = .fullScreen
        present(showRoomVc, animated: true, completion: nil)
    }
    private func pushMoramlRoom() {
        let normal = RoomNormalViewController()
        navigationController?.pushViewController(normal, animated: true)
    }
}
