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

public extension String {
    // MARK: property
    
    /// EUC-KR Encoding
    public var euckrEncoding: String {
        let rawEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.EUC_KR.rawValue))
        let encoding = String.Encoding(rawValue: rawEncoding)
        let eucKRStringData = self.data(using: encoding) ?? Data()
        let outputQuery = eucKRStringData.map {byte->String in
            if byte >= UInt8(ascii: "A") && byte <= UInt8(ascii: "Z")
                || byte >= UInt8(ascii: "a") && byte <= UInt8(ascii: "z")
                || byte >= UInt8(ascii: "0") && byte <= UInt8(ascii: "9")
                || byte == UInt8(ascii: "_") || byte == UInt8(ascii: ".")
                || byte == UInt8(ascii: "-") {
                guard let unicode = UnicodeScalar(UInt32(byte)) else{
                    return ""
                }
                return String(Character(unicode))
            } else if byte == UInt8(ascii: " ") {
                return "+"
            } else {
                return String(format: "%%%02X", byte)
            }
            }.joined()
        return outputQuery
    }
    
    
    
    /// Import koreanInitial.plist for initial autocomplete
    public var koreanInitialDict: [String: String]{
        guard let plist = Bundle(for: Util.self).path(forResource: "KoreanInitial", ofType: "plist") else {
            return [:]
        }
        guard let dict = NSDictionary(contentsOfFile: plist) as? [String: String] else {
            return [:]
        }
        return dict
    }
    
    
    /// localized
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    
    /// range
    public var range: Range<Index>{
        return self.index(self.startIndex, offsetBy: 0)..<self.index(self.startIndex, offsetBy: self.count-1)
    }
    
    
    
    /// url To Query Encoding
    public var queryEncoding: String{
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
    
    
    
    
    /// parseJSON
    public var parseJSON: AnyObject{
        guard let data = (self).data(using: String.Encoding.utf8) else{
            return "" as AnyObject
        }
        do {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
        } catch let error as NSError {
            print("parseJSON error \(error)")
        }
        return "" as AnyObject
    }
    
    
    
    
    /// base64 String Decoding
    public var base64Decoding: Data{
        return Data(base64Encoded: self, options:NSData.Base64DecodingOptions(rawValue: 0)) ?? Data()
    }
    
    
    
    
    
    /// Initial Auto Complete
    public var makeInitail: String{
        var out = ""
        for (index, _) in self.enumerated() {
            let oneChar: UniChar = NSString(string: self).character(at: index)
            if (oneChar >= 0xAC00 && oneChar <= 0xD7A3){
                let value = ((oneChar - 0xAC00)/28)/21 + 0x1100
                self.koreanInitialDict.keys.forEach({ (key) in
                    out = "\(out)\(self.compareInitialKey(value, key: key))"
                })
            }
        }
        return out
    }
    
    
    
    /// image ext
    public var ext: String{
        if self.uppercased().contains("PNG"){ return "PNG" }
        else if self.uppercased().contains("JPEG") || self.uppercased().contains("JPG"){ return "JPG" }
        else if self.uppercased().contains("GIT"){ return "GIF" }
        else { return "ETC" }
    }
    
    /// isPNG
    public var isPNG: Bool{
        if self.uppercased().contains("PNG"){ return true }
        else { return false }
    }
    
    /// isJPEG
    public var isJPEG: Bool{
        if self.uppercased().contains("JPEG") || self.uppercased().contains("JPG"){ return true }
        else { return false }
    }
    
    
    /// validate Email
    public var isValidEmail: Bool{
        let regEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    /// validate Url
    public var isValidUrl: Bool{
        let regEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    /// validate Ko
    public var isValidKo: Bool{
        let regEx = ".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    
    
    // MARK: func
    
    /**
     localized
     - parameter comment: String
     - returns: String
     */
    public func localizedWithComment(_ comment: String = "") -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
    
    
    
    /**
     substring
     - parameter from: Int
     - parameter to: Int
     - returns: String
     */
    public func substring(from: Int = 0, to: Int = -1) -> String {
        var toTmp = to
        if toTmp < 0 { toTmp = self.count + toTmp }
        let range = self.index(self.startIndex, offsetBy: from)..<self.index(self.startIndex, offsetBy: toTmp+1)
        return String(self[range])
    }
    
    /**
     substring
     - parameter from: Int
     - parameter length: Int
     - returns: String
     */
    public func substring(from:Int = 0, length: Int) -> String {
        let range = self.index(self.startIndex, offsetBy: from)..<self.index(self.startIndex, offsetBy: from+length)
        return String(self[range])
    }
    
    
    
    
    
    /**
     compareInitialKey
     - parameter value: UInt16
     - parameter key: String
     - returns: String
     */
    private func compareInitialKey(_ value: UInt16, key: String) -> String{
        var result = ""
        if value == UInt16(key) {
            if let value = self.koreanInitialDict[key]{ result = "\(value)" }
        }
        return result
    }
    
    
    
    
    /**
     Initial String Contains
     - parameter string: String
     - parameter noneSearch: Bool
     - returns: Bool
     */
    public func isContains(_ string: String, noneSearch: Bool = true) -> Bool{
        if string.count == 1 && string.makeInitail == ""{
            return string.isValidKo ? self.makeInitail.contains(string) : self.contains(string)
        }else{
            return string.count == 0 ? noneSearch : self.contains(string)
        }
    }
    
    
    
    
    
    
    /**
     Making the same character as NSRange in string
     - parameter words: String
     - returns: NSRange?
     */
    public func nsRange(_ words: String) -> NSRange? {
        guard let range = self.range(of: words) else{
            return nil
        }
        guard let lower = UTF16View.Index(range.lowerBound, within: utf16), let upper = UTF16View.Index(range.upperBound, within: utf16) else{
            return nil
        }
        return NSRange(location: lower.encodedOffset, length: upper.encodedOffset - lower.encodedOffset)
    }
    
    
    
    
    /// Create a class with String
    public func convertToClass<T>() -> T.Type? {
        return StringClassConverter<T>.convert(string: self)
    }
    
    /// Find the class with the same String.
    public func viewController() -> UIViewController?{
        guard let viewController: UIViewController.Type = self.convertToClass() else {
            return nil
        }
        return viewController.init()
    }
    
    
    /**
     String to Age
     - parameter format: String
     - returns: Double
     */
    public func age(_ format: String) -> Double{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        return dateFormatter.date(from: self)?.age.double ?? 0
    }
}


public class StringClassConverter<T> {
    /// String to Type
    public static func convert(string className: String) -> T.Type? {
        guard let nameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String else {
            return nil
        }
        guard let aClass: T.Type = NSClassFromString("\(nameSpace).\(className)") as? T.Type else {
            return nil
        }
        return aClass
    }
}
