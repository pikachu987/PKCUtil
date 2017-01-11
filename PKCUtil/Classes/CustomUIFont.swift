//
//  UIFont.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import UIKit

extension UIFont {
    static func printFontNames() {
        for familyName in UIFont.familyNames {
            print("Family name: \(familyName)")
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("Font name: \(fontName)")
            }
        }
    }
    static func fontNames() -> [String]{
        var fontArray = [String]()
        for familyName in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                fontArray.append(fontName)
            }
        }
        return fontArray
    }
}
