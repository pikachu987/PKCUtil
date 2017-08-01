//
//  Item.swift
//  Pods
//
//  Created by guanho on 2017. 4. 7..
//
//

//import Foundation
//import SwiftyJSON
//
//class Item {
//    static func value(ofUrl: Any?) -> String{
//        var url = ""
//        if let json = ofUrl as? JSON{
//            if let value = json.string{
//                url = value
//            }
//        }else if let value = ofUrl as? String{
//            url = value
//        }
//        //#이 들어가야되는데 #까지 %23으로 바껴서 다시 replace함
//        if let urlPath = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
//            url = urlPath.replacingOccurrences(of: "%23", with: "#")
//        }
//        return url
//    }
//
//    static func value(ofString: Any?) -> String{
//        if let json = ofString as? JSON{
//            if let value = json.string{
//                return value
//            }else if let value = json.double{
//                let val = "\(value)"
//                if val.hasSuffix(".0"){
//                    return val.substring(from: 0, length: val.characters.count - 2)
//                }else{
//                    return val
//                }
//            }else if let value = json.float{
//                let val = "\(value)"
//                if val.hasSuffix(".0"){
//                    return val.substring(from: 0, length: val.characters.count - 2)
//                }else{
//                    return val
//                }
//            }else if let value = json.bool{
//                return "\(value)"
//            }else if let value = json.int{
//                return "\(value)"
//            }
//        }else if let value = ofString as? String{
//            return value
//        }else if let value = ofString as? Double{
//            return "\(value)"
//        }else if let value = ofString as? Float{
//            return "\(value)"
//        }else if let value = ofString as? Bool{
//            return "\(value)"
//        }else if let value = ofString as? Int{
//            return "\(value)"
//        }
//        return ""
//    }
//
//
//
//
//
//    static func value(ofInt: Any?) -> Int{
//        if let json = ofInt as? JSON{
//            if let str = json.string, let value = Int(str){
//                return value
//            }else if let value = json.double{
//                return Int(value)
//            }else if let value = json.float{
//                return Int(value)
//            }else if let value = json.int{
//                return value
//            }
//        }else if let str = ofInt as? String,  let value = Int(str){
//            return value
//        }else if let value = ofInt as? Double{
//            return Int(value)
//        }else if let value = ofInt as? Float{
//            return Int(value)
//        }else if let value = ofInt as? Int{
//            return value
//        }
//        return 0
//    }
//
//
//
//
//    static func value(ofFloat: Any?) -> Float{
//        if let json = ofFloat as? JSON{
//            if let str = json.string, let value = Float(str){
//                return value
//            }else if let value = json.double{
//                return Float(value)
//            }else if let value = json.float{
//                return value
//            }else if let value = json.int{
//                return Float(value)
//            }
//        }else if let str = ofFloat as? String,  let value = Float(str){
//            return value
//        }else if let value = ofFloat as? Double{
//            return Float(value)
//        }else if let value = ofFloat as? Float{
//            return value
//        }else if let value = ofFloat as? Int{
//            return Float(value)
//        }
//        return 0
//    }
//
//
//
//
//    static func value(ofDouble: Any?) -> Double{
//        if let json = ofDouble as? JSON{
//            if let str = json.string, let value = Double(str){
//                return value
//            }else if let value = json.double{
//                return value
//            }else if let value = json.float{
//                return Double(value)
//            }else if let value = json.int{
//                return Double(value)
//            }
//        }else if let str = ofDouble as? String,  let value = Double(str){
//            return value
//        }else if let value = ofDouble as? Double{
//            return value
//        }else if let value = ofDouble as? Float{
//            return Double(value)
//        }else if let value = ofDouble as? Int{
//            return Double(value)
//        }
//        return 0
//    }
//
//
//
//
//    static func value(ofDate: Any?) -> Date{
//        if let json = ofDate as? JSON{
//            if let str = json.string, let value = Double(str){
//                return NSDate(timeIntervalSince1970: value) as Date
//            }else if let value = json.double{
//                return NSDate(timeIntervalSince1970: value) as Date
//            }else if let value = json.float{
//                return NSDate(timeIntervalSince1970: Double(value)) as Date
//            }else if let value = json.int{
//                return NSDate(timeIntervalSince1970: Double(value)) as Date
//            }
//        }else if let str = ofDate as? String,  let value = Double(str){
//            return NSDate(timeIntervalSince1970: value) as Date
//        }else if let value = ofDate as? Double{
//            return NSDate(timeIntervalSince1970: value) as Date
//        }else if let value = ofDate as? Float{
//            return NSDate(timeIntervalSince1970: Double(value)) as Date
//        }else if let value = ofDate as? Int{
//            return NSDate(timeIntervalSince1970: Double(value)) as Date
//        }
//        return Date()
//    }
//
//
//    static func value(ofBool: Any?) -> Bool{
//        if let json = ofBool as? JSON{
//            if let value = json.bool{
//                return value
//            }else if let value = json.string{
//                if value == "false" || value == "0.0" || value == "0"{
//                    return false
//                }else{
//                    return true
//                }
//            }else if let value = json.double{
//                return value == 0 ? false : true
//            }else if let value = json.float{
//                return value == 0 ? false : true
//            }else if let value = json.int{
//                return value == 0 ? false : true
//            }
//        }else if let value = ofBool as? Bool{
//            return value
//        }else if let value = ofBool as? String{
//            if value == "false" || value == "0.0" || value == "0"{
//                return false
//            }else{
//                return true
//            }
//        }else if let value = ofBool as? Double{
//            return value == 0 ? false : true
//        }else if let value = ofBool as? Float{
//            return value == 0 ? false : true
//        }else if let value = ofBool as? Int{
//            return value == 0 ? false : true
//        }
//        return false
//    }
//}
