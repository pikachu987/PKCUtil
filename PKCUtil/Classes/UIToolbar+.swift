//
//  UIToolbar+.swift
//  PKCUtil
//
//  Created by docfriends on 2017. 9. 20..
//

import UIKit

public extension UIToolbar{
    public static func doneTextField(_ color: UIColor?, target: Any?, action: Selector?) -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
        toolbar.barStyle = .default
        if let color = color{
            toolbar.backgroundColor = color
        }
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: target, action: action)
        toolbar.setItems(
            [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: target, action: nil),
                doneBarButtonItem
            ], animated: true)
        toolbar.sizeToFit()
        return toolbar
    }
}

