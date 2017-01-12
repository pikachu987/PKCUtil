//
//  String.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import Foundation

public extension String {
    public var localized: String {
        var bundle = Bundle.main
        if Util.bundle != nil{
            bundle = Util.bundle
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    public func localizedWithComment(_ comment:String = "") -> String {
        var bundle = Bundle.main
        if Util.bundle != nil{
            bundle = Util.bundle
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: comment)
    }
    //substring 추가
    public func substring(from:Int = 0, to:Int = -1) -> String {
        var toTmp = to
        if toTmp < 0 {
            toTmp = self.characters.count + toTmp
        }
        //from toTmp+1
        let range = self.characters.index(self.startIndex, offsetBy: from)..<self.characters.index(self.startIndex, offsetBy: toTmp+1)
        return self.substring(with: range)
    }
    public func substring(from:Int = 0, length:Int) -> String {
        let range = self.characters.index(self.startIndex, offsetBy: from)..<self.characters.index(self.startIndex, offsetBy: from+length)
        return self.substring(with: range)
    }
    
    public func range() -> Range<Index>{
        let range = self.characters.index(self.startIndex, offsetBy: 0)..<self.characters.index(self.startIndex, offsetBy: self.characters.count-1)
        return range
    }
    public func queryValue() -> String{
        let value = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return value!
    }
}
