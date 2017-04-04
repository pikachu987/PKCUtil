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
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    public func localizedWithComment(_ comment:String = "") -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
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
        guard let value = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else{
            return ""
        }
        return value
    }
    
    public func parseJSON() -> AnyObject{
        guard let data = (self).data(using: String.Encoding.utf8) else{
            return "" as AnyObject
        }
        var jsonResult :Any
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            return jsonResult as AnyObject
        } catch let error as NSError {
            print("parseJSON error \(error)")
            jsonResult = "" as AnyObject
        }
        return jsonResult as AnyObject
    }
    
    
    
    //확장자 구하기
    public func getExt(_ defaultExt : ExtType = .png) -> ExtType{
        if self.uppercased().range(of: "PNG") != nil{
            return .png
        }else if self.uppercased().range(of: "JPEG") != nil || self.uppercased().range(of: "JPG") != nil{
            return .jpeg
        }else {
            return defaultExt
        }
    }
    
    
    //base64 문자열 디코딩
    public func base64Decoding() -> Data{
        guard let imageData = Data(base64Encoded: self, options:NSData.Base64DecodingOptions(rawValue: 0)) else{
            return Data()
        }
        return imageData
    }
    
    
}
