//
//  UIColor+.swift
//  SlideTabKitDemo
//
//  Created by 周凌宇 on 2017/8/17.
//  Copyright © 2017年 周凌宇. All rights reserved.
//

import UIKit

public extension UIColor {
    /// 生成随机色
    public static var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random() % 256) / 255.0
            let green = CGFloat(arc4random() % 256) / 255.0
            let blue = CGFloat(arc4random() % 256) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
