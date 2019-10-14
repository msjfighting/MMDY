//
//  PageContentView.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/9.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat, sourceIndex:Int, targetIndex:Int)
}
private let contentId : String = "cell"
class PageContentView: UIView {
    private var chileVCs : [UIViewController]
    private weak var parentVC : UIViewController?
    private var startOffsetX : CGFloat = 0
    private var isForbidScrollDelegate : Bool =  false
    weak var delegate : PageContentViewDelegate?
    
    private lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentId)
        
        return collectionView
    }()
    
    init(frame: CGRect,childVCs : [UIViewController],parentVC : UIViewController) {
        self.chileVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView {
    private func setupUI() {
        // 将所有的子控制器添加到父控制器中
        for childvc in chileVCs {
            parentVC?.addChild(childvc)
        }
        // 添加collectionView,用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}
// 遵守协议
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chileVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentId, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childvc  = chileVCs[indexPath.row]
        childvc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childvc.view)
        return cell
    }
}
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
       startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {return}
        var progress: CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let offsetX : CGFloat = scrollView.contentOffset.x;
        let scrollW = scrollView.bounds.size.width
        if offsetX > startOffsetX {
            // 左滑
            progress = offsetX/scrollW - floor(offsetX/scrollW)
            sourceIndex = Int(offsetX/scrollW)
            targetIndex = sourceIndex + 1
            if targetIndex >= chileVCs.count{
                targetIndex = chileVCs.count - 1
            }
            if offsetX - startOffsetX == scrollW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{
            // 右滑
            progress = 1 - (offsetX/scrollW - floor(offsetX/scrollW))
            targetIndex = Int(offsetX/scrollW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= chileVCs.count{
                sourceIndex = chileVCs.count - 1
            }
            
        }
       
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    
    }
}

// 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        
        // 记录需要禁止我们的代理方法
        isForbidScrollDelegate = true
      let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX,y: 0), animated: false)
    }
}
