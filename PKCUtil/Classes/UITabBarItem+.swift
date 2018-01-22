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
    
    public func setEntity(_ title: String, imageName: String, color: UIColor){
        self.image = UIImage(named: imageName)?.renderingOriginal(color)
        self.selectedImage = UIImage(named: imageName)?.renderingOriginal(color)
        self.imageInsets = UIEdgeInsets.zero
        self.title = title
    }
    
    public func setEntity(_ title: String, imageName: String, color: UIColor, selectedColor: UIColor){
        self.image = UIImage(named: imageName)?.renderingOriginal(color)
        self.selectedImage = UIImage(named: imageName)?.renderingOriginal(selectedColor)
        self.imageInsets = UIEdgeInsets.zero
        self.title = title
    }
    
    public func setEntity(_ title: String, image: UIImage, selectedImage: UIImage){
        self.image = image
        self.selectedImage = selectedImage
        self.imageInsets = UIEdgeInsets.zero
        self.title = title
    }
}
