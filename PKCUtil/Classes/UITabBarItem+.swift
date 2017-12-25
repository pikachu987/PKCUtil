//
//  UITabBarItem+.swift
//  PKCUtil
//
//  Created by Kim Guanho on 2017. 12. 25..
//

import UIKit

public extension UITabBarItem{
    public func setEntity(_ title: String, imageName: String){
        self.image = UIImage(named: imageName)
        self.selectedImage = UIImage(named: imageName)
        self.imageInsets = UIEdgeInsets.zero
        self.title = title
    }
}
