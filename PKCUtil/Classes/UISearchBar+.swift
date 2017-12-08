//
//  UISearchBar+.swift
//  PKCUtil
//
//  Created by docfriends on 2017. 10. 12..
//

import UIKit

public extension UISearchBar{
    public var textField: UITextField{
        guard let textField = self.value(forKey: "_searchField") as? UITextField else {
            return UITextField()
        }
        return textField
    }
    public static func headerViewSearchBar(_ placeHolder: String, tintColor: UIColor = UIColor(red: 76/255, green: 109/255, blue: 234/255, alpha: 1)) -> UISearchBar{
        let searchBar = UISearchBar(frame: CGRect(x: 50, y: 26, width: UIScreen.main.bounds.width-66, height: 28))
        searchBar.tintColor = tintColor
        searchBar.placeholder = placeHolder
        searchBar.enablesReturnKeyAutomatically = false
        
        return searchBar
    }
}
