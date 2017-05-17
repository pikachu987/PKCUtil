//
//  UIColor.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    public static func color(_ color: CGFloat, alpha: CGFloat = 1) -> UIColor{
        return UIColor(red: color/255, green: color/255, blue: color/255, alpha: alpha)
    }
    
    //rgb
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    //hex로 컬러
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
    
    //value 구하기
    public var redValue: CGFloat{ return CIColor(color: self).red }
    public var greenValue: CGFloat{ return CIColor(color: self).green }
    public var blueValue: CGFloat{ return CIColor(color: self).blue }
    public var alphaValue: CGFloat{ return CIColor(color: self).alpha }
}
