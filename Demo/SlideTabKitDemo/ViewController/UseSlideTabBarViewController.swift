//
//  UseSlideTabBarViewController.swift
//  LPDBUIKit
//
//  Created by 周凌宇 on 2017/6/22.
//  Copyright © 2017年 周凌宇. All rights reserved.
//  单独使用 SlideTabBar Demo

import UIKit

class UseSlideTabBarViewController: UIViewController, SlideTabBarDelegate {

    var slideTabBar0: SlideTabBar = SlideTabBar()
    var slideTabBar1: SlideTabBar = SlideTabBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置 slideTabBar
        self.view.addSubview(slideTabBar0)
        // 设置 tabBarTitles 会按照默认的样式显示，每个 barItem 中有一个 titleLabel 显示标题
        slideTabBar0.backgroundColor = UIColor.white
        slideTabBar0.font = UIFont.systemFont(ofSize: 14)
        slideTabBar0.titleColor = UIColor(red: 102 / 255.0, green: 102 / 255.0, blue: 102 / 255.0, alpha: 1.0)
        slideTabBar0.selectedTitleColor = themeColor
        slideTabBar0.slideColor = themeColor
        // 其他属性设置完毕后调用 resetting
        slideTabBar0.resetting(titles: ["标签 1", "标签 2", "标签 3", "标签 4"])
        slideTabBar0.delegate = self

        // --------- 也可以自定义每个 barItem 的内容 ---------
        self.view.addSubview(slideTabBar1)
        var customerViews: [UIView] = []
        for _ in 0 ..< 4 {
            // 自定义你的 item 内容
            let customerView = UIView()
            customerView.backgroundColor = UIColor.randomColor
            // 加入 itemView 中
            customerViews.append(customerView)
        }
        slideTabBar1.resetting(barItems: customerViews)
        slideTabBar1.delegate = self
        // ---------------------------------------------------

        // 设置布局
        slideTabBar0.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.left.right.equalTo(self.view)
            make.height.equalTo(40)
        }

        slideTabBar1.snp.makeConstraints { (make) in
            make.top.equalTo(slideTabBar0.snp.bottom).offset(20)
            make.left.right.equalTo(self.view)
            make.height.equalTo(40)
        }
    }

    // MARK: - SlideTabBarDelegate

    func slideTabBar(_ slideTabBar: SlideTabBar, barItemDidClicked index: Int, barItem: UIView) {
        print("\(index) bar clicked")
        if slideTabBar == slideTabBar0 {
            // 这里仅仅是一个 demo
            for bi in slideTabBar0.barItems {
                UIView.animate(withDuration: 0.3) {
                    bi.subviews.first!.center = CGPoint(x: barItem.bounds.width / 2, y: barItem.bounds.height / 2)
                }
            }
            UIView.animate(withDuration: 0.3) {
                barItem.subviews.first!.center = CGPoint(x: barItem.bounds.width / 2, y: barItem.bounds.height / 2 - 5)
            }
        }
    }
}
