//
//  SlideTabBar.swift
//  LPDBUIKit
//
//  Created by 周凌宇 on 2017/6/22.
//  Copyright © 2017年 周凌宇. All rights reserved.
//

import UIKit
import SnapKit
import FrameKit

public protocol SlideTabBarDelegate: class {
    func slideTabBar(_ slideTabBar: SlideTabBar, barItemDidClicked index: Int, barItem: UIView)
}

open class SlideTabBar: UIView {

    /// 设置 titles 会按照默认的样式显示，每个 barItem 中有一个 titleLabel 显示标题
    open private(set) var titles: [String] = []
    /// ------ 设置 titles 时起作用 ------
    open var font: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            buttons.forEach { (button) in
                button.titleLabel?.font = font
            }
        }
    }
    open var titleColor: UIColor = UIColor(red: 102 / 255.0, green: 102 / 255.0, blue: 102 / 255.0, alpha: 1.0) {
        didSet {
            configTitlesColor()
        }
    }
    open var selectedTitleColor: UIColor = themeColor {
        didSet {
            configTitlesColor()
        }
    }
    private var buttons: [UIButton] = []
    /// --------------------------------

    /// 设置 barItems，使用自定义 item 样式
    open private(set) var barItems: [UIView] = []
    open weak var delegate: SlideTabBarDelegate?

    open var slideColor: UIColor = themeColor {
        didSet {
            slideView.backgroundColor = slideColor
        }
    }
    open var slideSize: CGSize = CGSize(width: 10, height: 3)
    lazy open var slideView: UIView = {
        let view = UIView()
        self.addSubview(view)
        return view
    }()
    open var slideViewBottomOffest: CGFloat = 0 {
        didSet {
            slideView.snp.remakeConstraints { (make) in
                make.centerX.equalTo(barItems[selectedIndex])
                make.bottom.equalTo(self).offset(slideViewBottomOffest)
                make.size.equalTo(self.slideSize)
            }
        }
    }

    open var selectedIndex: Int = 0

    // MARK: - Action

    @objc func barItemClicked(_ sender: UIButton) {
        for button in buttons {
            button.isSelected = false
        }
        sender.isSelected = true
        let index = self.buttons.index(of: sender)
        selectedIndex = index!
        configTitlesColor()
        moveSlideView()
        self.delegate?.slideTabBar(self, barItemDidClicked: index!, barItem: barItems[index!])
    }

    // MARK: - Public

    open func selectBarItem(_ index: Int) {
        barItemClicked(buttons[index])
    }

    open func update(titles: [String]) {
        guard (self.superview != nil) else {
            assertionFailure("SlideTabBar 没有 superview")
            return
        }
        guard titles.count >= 1 else {
            assertionFailure("SlideTabBar 至少需要一个 title")
            return
        }
        guard titles.count == self.titles.count else {
            assertionFailure("title 的数量和原先不一致")
            return
        }
        self.titles = titles

        for (index, value) in buttons.enumerated() {
            value.setTitle(titles[index], for: UIControlState.normal)
        }

    }

    /// 设置、初始化内部组件
    ///
    /// - Parameter titles: 标题数组
    open func resetting(titles: [String]) {
        guard (self.superview != nil) else {
            assertionFailure("SlideTabBar 没有 superview")
            return
        }

        guard titles.count >= 1 else {
            assertionFailure("SlideTabBar 至少需要一个 title")
            return
        }
        self.titles = titles

        // 清除 subviews
        self.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        self.buttons.removeAll()
        self.barItems.removeAll()
        addSubview(slideView)

        if titles.count == 1 {
            let view = UIView()
            barItems.append(view)
            addSubview(view)
            view.snp.remakeConstraints({ (make) in
                make.edges.equalTo(self)
            })

            let button = makeButton()
            button.setTitle(titles.first!, for: UIControlState.normal)
            view.addSubview(button)
            button.snp.remakeConstraints({ (make) in
                make.edges.equalTo(view)
            })
            buttons.append(button)
            button.addTarget(self, action: #selector(barItemClicked(_:)), for: UIControlEvents.touchUpInside)
            return
        }

        // 添加新的 subviews
        for index in 0 ..< titles.count {
            let view = UIView()
            barItems.append(view)
            self.addSubview(view)

            let button = makeButton()
            button.setTitle(titles[index], for: UIControlState.normal)
            view.addSubview(button)
            button.snp.remakeConstraints({ (make) in
                make.edges.equalTo(view)
            })
            if index == 0 {
                button.setTitleColor(selectedTitleColor, for: UIControlState.normal)
            }
            buttons.append(button)
            button.addTarget(self, action: #selector(barItemClicked(_:)), for: UIControlEvents.touchUpInside)
        }

        barItems.first?.snp.remakeConstraints({ (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(barItems.last!)
        })

        for index in 1 ..< titles.count {
            if index == titles.count - 1 {
                barItems[index].snp.remakeConstraints({ (make) in
                    make.left.equalTo(barItems[index - 1].snp.right)
                    make.top.bottom.equalTo(self)
                    make.right.equalTo(self)
                    make.width.equalTo(barItems.first!)
                })
            } else {
                barItems[index].snp.remakeConstraints({ (make) in
                    make.left.equalTo(barItems[index - 1].snp.right)
                    make.top.bottom.equalTo(self)
                    make.width.equalTo(barItems.first!)
                })
            }
        }
        configTitlesColor()
        settingSlideView()
    }

    /// 设置、初始化内部组件
    ///
    /// - Parameter barItems: 自定义 Item 数组
    open func resetting(barItems: [UIView]) {
        guard (self.superview != nil) else {
            assertionFailure("SlideTabBar 没有 superview")
            return
        }

        guard barItems.count >= 1 else {
            assertionFailure("SlideTabBar 至少需要一个 barItem")
            return
        }

        // clear all subviews
        self.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        self.buttons.removeAll()
        self.barItems.removeAll()
        addSubview(slideView)

        self.barItems = barItems

        if barItems.count == 1 {
            addSubview(barItems.first!)
            barItems.first!.snp.remakeConstraints({ (make) in
                make.edges.equalTo(self)
            })

            let button = makeButton()
            barItems.first!.addSubview(button)
            button.snp.remakeConstraints({ (make) in
                make.edges.equalTo(barItems.first!)
            })
            buttons.append(button)
            button.addTarget(self, action: #selector(barItemClicked(_:)), for: UIControlEvents.touchUpInside)
            settingSlideView()
            return
        }

        // add new subviews
        for itemView in barItems {
            addSubview(itemView)

            let button = makeButton()
            itemView.addSubview(button)
            button.snp.remakeConstraints({ (make) in
                make.edges.equalTo(itemView)
            })
            buttons.append(button)
            button.addTarget(self, action: #selector(barItemClicked(_:)), for: UIControlEvents.touchUpInside)
        }

        barItems.first?.snp.remakeConstraints({ (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(barItems.last!)
        })

        for index in 1 ..< barItems.count {
            if index == barItems.count - 1 {
                barItems[index].snp.remakeConstraints({ (make) in
                    make.left.equalTo(barItems[index - 1].snp.right)
                    make.top.bottom.equalTo(self)
                    make.right.equalTo(self)
                    make.width.equalTo(barItems.first!)
                })
            } else {
                barItems[index].snp.remakeConstraints({ (make) in
                    make.left.equalTo(barItems[index - 1].snp.right)
                    make.top.bottom.equalTo(self)
                    make.width.equalTo(barItems.first!)
                })
            }
        }
        settingSlideView()
    }

    open func settingSlideView(progress: CGFloat) {
        guard barItems.count > 0 else {
            assertionFailure("SlideTabBar 至少需要一个 barItem")
            return
        }
        let length = barItems.count == 1 ? 0 : progress * self.fkit.width * CGFloat(barItems.count - 1) / CGFloat(barItems.count)
        slideView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(barItems.first!).offset(length)
            make.bottom.equalTo(self).offset(slideViewBottomOffest)
            make.size.equalTo(self.slideSize)
        }
    }

    // MARK: - Private

    private func settingSlideView()  {
        slideView.backgroundColor = slideColor
        slideView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(barItems[selectedIndex])
            make.bottom.equalTo(self)
            make.size.equalTo(self.slideSize)
        }
    }

    open override func layoutSubviews() {

    }

    private func moveSlideView() {
        slideView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(barItems[selectedIndex])
            make.bottom.equalTo(self).offset(slideViewBottomOffest)
            make.size.equalTo(self.slideSize)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    private func makeButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(titleColor, for: UIControlState.normal)
        button.titleLabel?.font = font
        return button
    }

    func configTitlesColor() {
        buttons.forEach { (button) in
            if buttons.index(of: button) == selectedIndex {
                button.setTitleColor(selectedTitleColor, for: UIControlState.normal)
            } else {
                button.setTitleColor(titleColor, for: UIControlState.normal)
            }
        }
    }
}
