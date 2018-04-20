//Copyright (c) 2017 pikachu987 <pikachu987@naver.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

import Foundation
import UIKit

// UIDeviceModelType
public enum UIDeviceModelType: String{
    case none = "none"
    case iPod = "iPod"
    case iPad = "iPad"
    case appleTV = "appleTV"
    case iPhone = "iPhone"
    case iPhone4 = "iPhone4"
    case iPhone5 = "iPhone5"
    case iPhone6 = "iPhone6"
    case iPhone7 = "iPhone7"
    case iPhone8 = "iPhone8"
    case iPhoneSE = "iPhoneSE"
    case iPhone6Plus = "iPhone6Plus"
    case iPhone7Plus = "iPhone7Plus"
    case iPhone8Plus = "iPhone8Plus"
    case iPhoneX = "iPhoneX"
}


public extension UIDevice {
    // MARK: func
    
    /**
     modelName
     - parameter machineString: String
     - returns: String
     */
    public func modelName(machineString: String) -> String{
        #if targetEnvironment(simulator)
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                return self.getMachineString(dir)
            }else{
                return ""
            }
        #else
            return self.getMachineString(machineString)
        #endif
    }

    /**
     modelName
     - parameter machineString: String
     - returns: UIDeviceModelType
     */
    public func modelNameType(machineString: String) -> UIDeviceModelType{
        #if targetEnvironment(simulator)
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                return self.getModelType(dir)
            }else{
                return .none
            }
        #else
            return self.getModelType(machineString)
        #endif
    }

    /**
     getModelType
     - parameter machineString: String
     - returns: UIDeviceModelType
     */
    func getModelType(_ machineString: String) -> UIDeviceModelType{
        switch machineString {
        case "iPod5,1":                                 return .iPod
        case "iPod7,1":                                 return .iPod
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return .iPhone4
        case "iPhone4,1":                               return .iPhone4
        case "iPhone5,1", "iPhone5,2":                  return .iPhone5
        case "iPhone5,3", "iPhone5,4":                  return .iPhone5
        case "iPhone6,1", "iPhone6,2":                  return .iPhone5
        case "iPhone7,2":                               return .iPhone6
        case "iPhone7,1":                               return .iPhone6Plus
        case "iPhone8,1":                               return .iPhone6
        case "iPhone8,2":                               return .iPhone6Plus
        case "iPhone8,4":                               return .iPhoneSE
        case "iPhone9,1", "iPhone9,3":                  return .iPhone7
        case "iPhone9,2", "iPhone9,4":                  return .iPhone7Plus
        case "iPhone10,3":                              return .iPhoneX
        case "iPhone10,4":                              return .iPhone8
        case "iPhone10,5":                              return .iPhone8Plus
        case "iPhone10,6":                              return .iPhoneX
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return .iPad
        case "iPad3,1", "iPad3,2", "iPad3,3":           return .iPad
        case "iPad3,4", "iPad3,5", "iPad3,6":           return .iPad
        case "iPad4,1", "iPad4,2", "iPad4,3":           return .iPad
        case "iPad5,3", "iPad5,4":                      return .iPad
        case "iPad2,5", "iPad2,6", "iPad2,7":           return .iPad
        case "iPad4,4", "iPad4,5", "iPad4,6":           return .iPad
        case "iPad4,7", "iPad4,8", "iPad4,9":           return .iPad
        case "iPad5,1", "iPad5,2":                      return .iPad
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return .iPad
        case "AppleTV5,3":                              return .appleTV
        default:
            if machineString.lowercased().contains("ipad"){
                return .iPad
            }else if machineString.lowercased().contains("iphone"){
                return .iPhone
            }else if machineString.lowercased().contains("ipod"){
                return .iPod
            }else if machineString.lowercased().contains("appletv"){
                return .appleTV
            }
            return .none
        }
    }


    /**
     getMachineString
     - parameter machineString: String
     - returns: String
     */
    func getMachineString(_ machineString: String) -> String{
        switch machineString {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone10,3":                              return "iPhoneX"
        case "iPhone10,4":                              return "iPhone 8"
        case "iPhone10,5":                              return "iPhone 8 Plus"
        case "iPhone10,6":                              return "iPhoneX"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        default:                                        return machineString
        }
    }
}






//extension UIDevice{
//    public var modelName: String {
//        var systemInfo = utsname()
//        _ = uname(&systemInfo)
//        let machineString = Mirror(reflecting: systemInfo.machine).children.reduce("") { identifier, element in
//            guard let value = element.value as? Int8, value != 0 else { return identifier }
//            return identifier + String(UnicodeScalar(UInt8(value)))
//        }
//        return self.modelName(machineString: machineString)
//    }
//
//    public var modelNameType: UIDeviceModelType {
//        var systemInfo = utsname()
//        _ = uname(&systemInfo)
//        let machineString = Mirror(reflecting: systemInfo.machine).children.reduce("") { identifier, element in
//            guard let value = element.value as? Int8, value != 0 else { return identifier }
//            return identifier + String(UnicodeScalar(UInt8(value)))
//        }
//        return self.modelNameType(machineString: machineString)
//    }
//}
