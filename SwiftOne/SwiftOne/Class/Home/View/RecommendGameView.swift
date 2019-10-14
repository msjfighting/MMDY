//
//  RecommendGameView.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/11.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

private let kCellW : CGFloat = 90
class RecommendGameView: UIView {
    var groups : [BaseModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    @IBOutlet var collectionView: UICollectionView!

    override func layoutSubviews() {
       super.layoutSubviews()
       collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: "CollectionGameCell")
       let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: kCellW, height: self.bounds.size.height)
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
}
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionGameCell", for: indexPath) as! CollectionGameCell
        cell.model = groups?[indexPath.item]
        return cell
    }
    
    
}
