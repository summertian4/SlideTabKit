//
//  UseSlideTabKitViewController.swift
//  LPDBUIKit
//
//  Created by 周凌宇 on 2017/6/22.
//  Copyright © 2017年 周凌宇. All rights reserved.
//

import UIKit
import SnapKit

class UseSlideTabKitViewController: UIViewController {

    var slideTabKit: SlideTabKit = SlideTabKit()
    var vcs: [UIViewController] = []
    var titles: [String] = ["标签 0", "标签 1", "标签 2", "标签 3"]

    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 0 ..< 4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor
            vcs.append(vc)
        }
        view.addSubview(slideTabKit.slideTabBar)
        slideTabKit.slideTabBar.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(40)
        }
        slideTabKit.slideTabBar.resetting(titles: titles)

        view.addSubview(slideTabKit.slideScrollView)
        slideTabKit.slideScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(slideTabKit.slideTabBar.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
        slideTabKit.slideScrollView.resetting(childViews: vcs.map({ (vc) -> UIView in
            return vc.view
        }))
    }
}

