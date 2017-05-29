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


    //어레이를 이중어레이로 나누기
    public func division(_ count: Int) -> [[Element]]{
        var array = [[Element]]()
        var tempArray = [Element]()
        for (index, element) in self.enumerated(){
            if tempArray.count != 0 && index % count == 0{
                array.append(tempArray)
                tempArray = [Element]()
            }
            tempArray.append(element)
        }
        if tempArray.count != 0{
            array.append(tempArray)
        }
        return array
    }

    //랜덤 아이템
    public func random() -> Element{
        let random = Int(arc4random_uniform(UInt32(self.count)))
        return self[random]
    }
}

