//
//  RecommendcycleView.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/11.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

class RecommendcycleView: UIView {
    
    @IBOutlet var collectionView: UICollectionView!

    @IBOutlet var pagecontroller: UIPageControl!
    
    var cycleTimer : Timer?

    var cycleDatas : [CycleModel]? {
        didSet {
            collectionView.reloadData()
            pagecontroller.numberOfPages = cycleDatas?.count ?? 0
             // 无线轮播 步骤 4
            let indexPath = IndexPath(item: (cycleDatas?.count ??  0)*10, section: 0)
            collectionView.selectItem(at: indexPath , animated: false, scrollPosition: .left)
            
            removeTimer()
            addTimer()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCycleCell")
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
         layout.itemSize = collectionView.bounds.size
         layout.minimumLineSpacing = 0;
         layout.minimumInteritemSpacing = 0
         layout.scrollDirection = .horizontal
         collectionView.isPagingEnabled = true
    }
}

extension RecommendcycleView {
    class func recommendCycleView() -> RecommendcycleView {
        
        return Bundle.main.loadNibNamed("RecommendcycleView", owner: nil, options: nil)?.first as! RecommendcycleView
    }
}

extension RecommendcycleView : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 无线轮播 步骤 1 * 10000
        return (cycleDatas?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCycleCell", for: indexPath) as! CollectionCycleCell
         // 无线轮播 步骤 2 indexPath.item % cycleDatas!.count
        let model = cycleDatas![indexPath.item % cycleDatas!.count]
        cell.cycle = model
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x  + scrollView.bounds.width * 0.5
        // 无线轮播 步骤 3 Int(offsetX / scrollView.bounds.width) % (cycleDatas?.count ?? 1)
        pagecontroller.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleDatas?.count ?? 1)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addTimer()
    }
}

extension RecommendcycleView {
    private func addTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    private func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
