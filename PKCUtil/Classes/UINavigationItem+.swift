//
//  UINavigationItem+.swift
//  Pods
//
//  Created by pikachu987 on 2017. 8. 1..
//
//

import UIKit

public extension UINavigationItem{
    public func addLeftItem(_ item: UIBarButtonItem){
        if self.leftBarButtonItems == nil{
            self.leftBarButtonItems = [UIBarButtonItem]()
            self.leftBarButtonItems?.append(item)
        }else{
            self.leftBarButtonItems?.append(item)
        }
    }

    public func addRightItem(_ item: UIBarButtonItem){
        if self.rightBarButtonItems == nil{
            self.rightBarButtonItems = [UIBarButtonItem]()
            self.rightBarButtonItems?.append(item)
        }else{
            self.rightBarButtonItems?.append(item)
        }
    }
}
