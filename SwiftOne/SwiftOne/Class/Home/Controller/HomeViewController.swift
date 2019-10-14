//
//  HomeViewController.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/9.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {
    // 闭包中使用self时 加[weak self] in
    private lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kNavigationBarH, width: kScreenWidth , height:kTitleViewH)
       let titles = ["推荐","游戏","娱乐","趣玩"]
       let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()

    private lazy var pageContentView : PageContentView = {[weak self] in
        let contentH : CGFloat = kScreenHeight - kNavigationBarH - kTitleViewH - CGFloat(kTabbarH);
        let contentFrame = CGRect(x: 0, y:  kNavigationBarH + kTitleViewH, width: kScreenWidth , height:contentH)
        
        var chiledvcs = [UIViewController]()
        chiledvcs.append(RecommendViewController())
        chiledvcs.append(GameViewController())
        chiledvcs.append(AmuseViewController())
        chiledvcs.append(FunnyViewController())
        let pageContentView = PageContentView(frame: contentFrame,childVCs: chiledvcs,parentVC: self!)
        pageContentView.delegate = self
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
    }
}

// MARK 设置UI界面
extension HomeViewController{
    private func setupUI() {
        
        //不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    private func setupNavigationBar() {

        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
    
        let size = CGSize.init(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highName: "Image_my_history_click", size: size)
    
        let searchItem = UIBarButtonItem(imageName: "btn_search", highName: "btn_search_clicked", size: size)
    
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem];
    }
}

// 遵守协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectIndex: Int) {
         pageContentView.setCurrentIndex(currentIndex: selectIndex)
    }
}
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


