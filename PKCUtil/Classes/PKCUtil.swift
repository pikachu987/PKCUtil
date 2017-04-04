//
//  PKCUtil.swift
//  PKCUtil
//
//  Created by guanho on 2016. 4. 6..
//  Copyright © 2016년 guanho. All rights reserved.
//

import Foundation
import UIKit

public enum ExtType{
    case jpeg, png
}
open class PKCUtil{
    open static var language : String{
        if let value = (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode) as? String{
            return value
        }else{
            return "en"
        }
    }
    open static var locale : String{
        if let value = (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String{
            return value
        }else{
            return "US"
        }
    }
    open static var nsVersion : String{
        if let value = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String{
            return value
        }else{
            return "1.0"
        }
    }
    open static var deviceId : String{
        if let value = UIDevice.current.identifierForVendor?.uuidString{
            return value
        }else{
            return ""
        }
    }
}
