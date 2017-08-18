//
//  SlideTabKit.swift
//  LPDBusiness
//
//  Created by 周凌宇 on 2017/6/22.
//  Copyright © 2017年 LPD. All rights reserved.
//

import UIKit

let themeColor = UIColor(red: 0.0, green: 131 / 255.0, blue: 251 / 255.0, alpha: 1.0)

public protocol SlideTabKitDelegate: class {
    func slideTabKit(_ slideTabKit: SlideTabKit, didShowPage index: Int)
    func slideTabKit(_ slideTabKit: SlideTabKit, progress: CGFloat)
    func slideTabKit(_ slideTabKit: SlideTabKit, barItemDidClicked index: Int, barItem: UIView)
}

open class SlideTabKit {
    open private(set) var slideTabBar: SlideTabBar = SlideTabBar()
    open private(set)var slideScrollView: SlideScrollView = SlideScrollView()
    open weak var delegate: SlideTabKitDelegate?
    /// 设置 tabBarTitles 会按照默认的样式显示，每个 barItem 中有一个 titleLabel 显示标题
    public init() {
        slideTabBar.delegate = self
        slideScrollView.delegate = self
    }
}

// MARK: - 处理 SlideTabBar 事件
extension SlideTabKit: SlideTabBarDelegate {
    public func slideTabBar(_ slideTabBar: SlideTabBar, barItemDidClicked index: Int, barItem: UIView) {
        slideScrollView.showPage(index: index)
        delegate?.slideTabKit(self, didShowPage: index)
        delegate?.slideTabKit(self, barItemDidClicked: index, barItem: barItem)
    }
}

// MARK: - 处理 SlideScrollView 事件
extension SlideTabKit: SlideScrollViewDelegate {
    public func slideScrollView(_ slideScrollView: SlideScrollView, progress: CGFloat) {
        slideTabBar.settingSlideView(progress: progress)
        delegate?.slideTabKit(self, progress: progress)
    }

    public func slideScrollView(_ slideScrollView: SlideScrollView, showPage index: Int) {
        slideTabBar.selectBarItem(index)
        delegate?.slideTabKit(self, didShowPage: index)
    }
}
