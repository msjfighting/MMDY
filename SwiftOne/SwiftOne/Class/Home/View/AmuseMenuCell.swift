//
//  AmuseMenuCell.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/12.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
private let kMenuItemMargin : CGFloat = 10

class AmuseMenuCell: UICollectionViewCell {

    @IBOutlet var collectionView: UICollectionView!
    
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: "CollectionGameCell")
          let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
          let kCellW = collectionView.bounds.width/4
          let kCellH = collectionView.bounds.height/2
           layout.itemSize = CGSize(width: kCellW, height: kCellH)
           layout.minimumLineSpacing = 0;
           layout.minimumInteritemSpacing = 0
           layout.scrollDirection = .vertical
           collectionView.isPagingEnabled = true
      }
}
extension AmuseMenuCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {
            return 0
        }
        return groups!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionGameCell", for: indexPath) as! CollectionGameCell
        cell.model = groups?[indexPath.item]
         return cell
     }
    
    
}
