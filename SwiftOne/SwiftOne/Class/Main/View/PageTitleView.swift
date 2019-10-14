//
//  PageTitleView.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/9.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class{
    func pageTitleView(titleView : PageTitleView,selectIndex : Int)
}

private let scrollViewH : CGFloat = 2
private let kNomalColor : (CGFloat, CGFloat, CGFloat) = (85,85,85)
private let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255,128,0)

class PageTitleView: UIView {
    private var currentIndex : Int = 0
    private var titles : [String]
    weak  var delegate : PageTitleViewDelegate?
    
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    // 懒加载
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
            let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    init(frame: CGRect,titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
    
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView {
    private func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        setupTitleLabels()
        setupBottomMenuAndScrollLine()
    }
    
    // 添加底部线与滚动的线
    private func setupBottomMenuAndScrollLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        
        let lineH : CGFloat = 0.5
    
        bottomLine.frame = CGRect(x: 0,y: frame.height - lineH,width: frame.width,height: lineH)
        
        addSubview(bottomLine)
        
        // 添加滚动的线
        
       guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor =  UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect.init(x: firstLabel.frame.origin.x, y: frame.height - scrollViewH, width: firstLabel.frame.size.width, height: scrollViewH)
    }
    
    // 添加wtitle
    private func setupTitleLabels() {
        let labelW : CGFloat = frame.size.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - scrollViewH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: kNomalColor.0, g: kNomalColor.1, b: kNomalColor.2)
            label.textAlignment = .center
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX,y: labelY,width: labelW,height: labelH)
            
            titleLabels.append(label)
            scrollView.addSubview(label)
            
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tap)
        }
    }
}

extension PageTitleView {
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer) {
        // 获取label的下标
       guard let currentLabel = tapGes.view as? UILabel else {return}
        
        // 重复点击
        if currentLabel.tag == currentIndex { return }
        
        let oldLabel = titleLabels[currentIndex]
    
        oldLabel.textColor =  UIColor(r: kNomalColor.0, g: kNomalColor.1, b: kNomalColor.2)
        currentLabel.textColor =  UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        currentIndex = currentLabel.tag
        
        // 滚动条位置 发生改变
        
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        delegate?.pageTitleView(titleView: self, selectIndex: currentIndex)
    }
}

extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 颜色渐变
        // 取出变化值的范围
        let colorDelta = (kSelectedColor.0 - kNomalColor.0,kSelectedColor.1 - kNomalColor.1,kSelectedColor.2 - kNomalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress , g: kSelectedColor.1 - colorDelta.1 * progress , b: kSelectedColor.2 - colorDelta.2 * progress)
        
         targetLabel.textColor = UIColor(r: kNomalColor.0 + colorDelta.0 * progress , g: kNomalColor.1 + colorDelta.1 * progress , b: kNomalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targetIndex
    }
}
