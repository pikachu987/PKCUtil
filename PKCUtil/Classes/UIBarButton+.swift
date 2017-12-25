//
//  UIBarButton+.swift
//  Pods
//
//  Created by pikachu987 on 2017. 8. 1..
//
//

import UIKit

public extension UIBarButtonItem{
    public static func item(named: String, target: Any?, action: Selector?) -> UIBarButtonItem{
        let menu = UIImage(named: named)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        let barButtonItem = UIBarButtonItem(image: menu, style: .plain, target: target, action: action)
        return barButtonItem
    }

    public static func item(barButtonSystemItem: UIBarButtonSystemItem, target: Any?, action: Selector?) -> UIBarButtonItem{
        return UIBarButtonItem(barButtonSystemItem: barButtonSystemItem, target: target, action: action)
    }
}


