//
//  Array+.swift
//  Pods
//
//  Created by guanho on 2017. 4. 1..
//
//

import Foundation

public extension Array{
    
    //json형태를 string으로 만듬
    public func JSONStringify(prettyPrinted:Bool = false) -> String{
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        if JSONSerialization.isValidJSONObject(self) {
            do{
                let data = try JSONSerialization.data(withJSONObject: self, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch let error as NSError {
                print("JSON stringify error \(error)")
                //Access error here
            }
        }
        return ""
    }
}

