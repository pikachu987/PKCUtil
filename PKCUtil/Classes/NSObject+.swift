//
//  NSObject+.swift
//  PKCUtil
//
//  Created by docfriends on 2017. 11. 17..
//

import Foundation

public extension NSObject{
    public var classNameToString: String {
        return NSStringFromClass(type(of: self))
    }
    public static var classNameToString: String{
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}
