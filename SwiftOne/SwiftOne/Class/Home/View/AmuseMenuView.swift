//
//  AmuseMenuView.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/12.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

class AmuseMenuView: UIView {


    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var pageComtrol: UIPageControl!
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.register(UINib(nibName: "AmuseMenuCell", bundle: nil), forCellWithReuseIdentifier: "AmuseMenuCell")
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
         layout.itemSize = collectionView.bounds.size
         layout.minimumLineSpacing = 0;
         layout.minimumInteritemSpacing = 0
         layout.scrollDirection = .horizontal
         collectionView.isPagingEnabled = true
    }
}

extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}


extension AmuseMenuView : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {
            return 0
        }
        let count = (groups!.count - 1)/8 + 1
        pageComtrol.numberOfPages = count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmuseMenuCell", for: indexPath) as! AmuseMenuCell
        setupCellDataWithCell(cell : cell,indexPath : indexPath)
        return cell
    }
 
    private func setupCellDataWithCell(cell : AmuseMenuCell,indexPath: IndexPath) {
        // 0 : 0~7
        // 1 : 8~15
        // 3 : 16~23
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        if endIndex > groups!.count-1 {
            endIndex = groups!.count - 1
        }
        
        cell.groups = Array(groups![startIndex...endIndex])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageComtrol.currentPage = Int(scrollView.contentOffset.x / collectionView.bounds.size.width)
    }
}
