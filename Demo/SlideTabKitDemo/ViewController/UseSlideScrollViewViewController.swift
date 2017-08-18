//
//  UseSlideScrollViewViewController.swift
//  LPDBUIKit
//
//  Created by 周凌宇 on 2017/6/23.
//  Copyright © 2017年 周凌宇. All rights reserved.
//

import UIKit
//import LPDBPublicModule

class UseSlideScrollViewViewController: UIViewController, SlideScrollViewDelegate {
    var slideScrollView: SlideScrollView = SlideScrollView()
    var vcs: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 0 ..< 4 {
            let vc = UIViewController()
            addChildViewController(vc)
            vcs.append(vc)
            
            vc.view.backgroundColor = UIColor.randomColor
        }

        self.view.addSubview(slideScrollView)
        let views = vcs.map { (viewController) -> UIView in
            return viewController.view
        }
        slideScrollView.resetting(childViews: views)
        slideScrollView.delegate = self
        slideScrollView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

    func slideScrollView(_ slideScrollView: SlideScrollView, showPage index: Int) {
        print("\(index) page show")
    }

    func slideScrollView(_ slideScrollView: SlideScrollView, progress: CGFloat) {
        print("\(progress)%")
    }
}
