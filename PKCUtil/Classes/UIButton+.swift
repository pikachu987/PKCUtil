//
//  UIButton+.swift
//  PKCUtil
//
//  Created by docfriends on 2017. 11. 14..
//

import UIKit

public extension UIButton{
    public convenience init(title: String, font: UIFont, titleColor: UIColor = UIColor.blue, backgroundColor: UIColor = UIColor.clear){
        self.init()
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    public convenience init(image: UIImage) {
        self.init(type: .custom)
        self.setTitle("", for: .normal)
        self.setImage(image, for: .normal)
    }
}
