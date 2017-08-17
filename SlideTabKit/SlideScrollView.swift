//
//  SlideScrollView.swift
//  LPDBUIKit
//
//  Created by 周凌宇 on 2017/6/23.
//  Copyright © 2017年 周凌宇. All rights reserved.
//

import UIKit
import LPDBPublicModule

public protocol SlideScrollViewDelegate: class {
    func slideScrollView(_ slideScrollView: SlideScrollView, showPage index: Int)
    func slideScrollView(_ slideScrollView: SlideScrollView, progress: CGFloat)
}

open class SlideScrollView: UIView, UIScrollViewDelegate {
    open private(set) var mainScroll: UIScrollView = UIScrollView()
    open private(set) var childViews: [UIView] = []
    open var showsVerticalScrollIndicator: Bool = false
    open var showsHorizontalScrollIndicator: Bool = false
    open weak var delegate: SlideScrollViewDelegate?

    open func resetting(childViews: [UIView]) {
        guard (self.superview != nil) else {
            assertionFailure("SlideScrollView 没有 superview")
            return
        }

        guard childViews.count >= 1 else {
            assertionFailure("SlideScrollView 至少需要一个 childView")
            return
        }
        subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        self.childViews = childViews
        addSubview(mainScroll)
        mainScroll.snp.remakeConstraints { (make) in
            make.edges.equalTo(self)
        }
        mainScroll.isPagingEnabled = true
        mainScroll.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        mainScroll.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        mainScroll.delegate = self

        for (index, value) in childViews.enumerated() {
            mainScroll.addSubview(value)
            if index == 0 {
                value.snp.remakeConstraints({ (make) in
                    make.left.top.bottom.equalTo(mainScroll)
                    make.width.equalTo(value.superview!)
                    make.height.equalTo(value.superview!)
                })
            } else if index == childViews.count - 1 {
                let lastValue = childViews[index - 1]
                value.snp.remakeConstraints({ (make) in
                    make.left.equalTo(lastValue.snp.right)
                    make.top.bottom.right.equalTo(value.superview!)
                    make.width.equalTo(value.superview!)
                    make.height.equalTo(value.superview!)
                })
            } else {
                let lastValue = childViews[index - 1]
                value.snp.remakeConstraints({ (make) in
                    make.left.equalTo(lastValue.snp.right)
                    make.top.bottom.equalTo(value.superview!)
                    make.width.equalTo(value.superview!)
                    make.height.equalTo(value.superview!)
                })
            }
        }
    }

    open func showPage(index: Int) {
        let offset = CGPoint(x: CGFloat(index) *  mainScroll.lpd.width, y: 0)
        mainScroll.setContentOffset(offset, animated: true)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isDecelerating || scrollView.isDragging {
            let ratio = CGFloat(childViews.count - 1) / CGFloat(childViews.count)
            let full: CGFloat = mainScroll.contentSize.width * CGFloat(ratio)
            let progress = CGFloat(mainScroll.contentOffset.x / full)
            self.delegate?.slideScrollView(self, progress: progress)
        }
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(mainScroll.contentOffset.x / mainScroll.lpd.width);
        self.delegate?.slideScrollView(self, showPage: page)
    }
}
