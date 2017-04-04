//
//  Data+.swift
//  Pods
//
//  Created by guanho on 2017. 4. 1..
//
//

import Foundation

public extension Data{
    //base64 문자열 인코딩
    public func base64Encoding() -> String{
        let base64String = self.base64EncodedString(options: [])
        return base64String
    }
    
    public func convertStringToDictionary() -> [String:AnyObject] {
        do {
            guard let json = try JSONSerialization.jsonObject(with: self, options: []) as? [String:AnyObject] else {
                return Dictionary()
            }
            return json
        } catch let error as NSError {
            print(error)
        }
        return Dictionary()
    }
}
