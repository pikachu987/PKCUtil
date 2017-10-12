//
//  UISearchBar+.swift
//  PKCUtil
//
//  Created by docfriends on 2017. 10. 12..
//

import UIKit

public extension UISearchBar{
    public static func headerViewSearchBar(_ placeHolder: String) -> UISearchBar{
        let searchBar = UISearchBar(frame: CGRect(x: 50, y: 26, width: UIScreen.main.bounds.width-66, height: 28))
        searchBar.placeholder = placeHolder
        searchBar.enablesReturnKeyAutomatically = false
        return searchBar
    }
}
