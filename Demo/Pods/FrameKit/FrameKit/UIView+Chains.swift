//
//  UIView+Chains.swift
//  PromiseKitDemo
//
//  Created by 周凌宇 on 2017/7/20.
//  Copyright © 2017年 周凌宇. All rights reserved.
//

import UIKit

public extension UIView {
    public var fkit: UIViewExtension {
        get {
            return UIViewExtension(self)
        }
    }
}

public class UIViewExtension {
    var view: UIView

    init(_ view: UIView) {
        self.view = view
    }

    public var x: CGFloat {
        get {
            return view.fkit_x
        }
        set {
            view.fkit_x = newValue
        }
    }
    public var y: CGFloat {
        get {
            return view.fkit_y
        }
        set {
            view.fkit_y = newValue
        }
    }
    public var width: CGFloat {
        get {
            return view.fkit_width
        }
        set {
            view.fkit_width = newValue
        }
    }
    public var height: CGFloat {
        get {
            return view.fkit_height
        }
        set {
            view.fkit_height = height
        }
    }
    public var size: CGSize {
        get {
            return view.fkit_size
        }
        set {
            view.fkit_size = newValue
        }
    }
    public var centerX: CGFloat {
        get {
            return view.fkit_centerX
        }
        set {
            view.fkit_centerX = newValue
        }
    }
    public var centerY: CGFloat {
        get {
            return view.fkit_centerY
        }
        set {
            view.fkit_centerY = newValue
        }
    }
    public var top: CGFloat {
        get {
            return view.fkit_top
        }
        set {
            view.fkit_top = newValue
        }
    }
    public var bottom: CGFloat {
        get {
            return view.fkit_bottom
        }
        set {
            view.fkit_bottom = newValue
        }
    }
    public var left: CGFloat {
        get {
            return view.fkit_left
        }
        set {
            view.fkit_left = newValue
        }
    }
    public var right: CGFloat {
        get {
            return view.fkit_right
        }
        set {
            view.fkit_right = newValue
        }
    }
}

extension UIView {
    var fkit_x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var fkit_y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    var fkit_width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    var fkit_height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    var fkit_size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    var fkit_centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    var fkit_centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    var fkit_top: CGFloat {
        get {
            return self.fkit_y
        }
        set {
            self.fkit_y = newValue
        }
    }
    var fkit_bottom: CGFloat {
        get {
            return self.fkit_y + self.fkit_height
        }
        set {
            self.fkit_y = newValue - self.fkit_height;
        }
    }
    var fkit_left: CGFloat {
        get {
            return self.fkit_x
        }
        set {
            self.fkit_x = newValue
        }
    }
    var fkit_right: CGFloat {
        get {
            return self.fkit_x + self.fkit_width
        }
        set {
            self.fkit_x = newValue - self.fkit_width
        }
    }
}

