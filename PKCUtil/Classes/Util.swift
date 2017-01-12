//
//  Util.swift
//  JundanJiZone
//
//  Created by guanho on 2016. 4. 6..
//  Copyright © 2016년 guanho. All rights reserved.
//

import Foundation
import UIKit

public enum ExtType{
    case jpeg, png
}
open class Util{
    open static var bundle: Bundle!
    
    open static let language : String = ((Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode) as? String)!
    open static let locale = ((Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String)!
    open static let nsVersion : String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    open static let deviceId : String = UIDevice.current.identifierForVendor!.uuidString
    open static let screenSize: CGRect = UIScreen.main.bounds
    open static func lang(_ key : String) -> String{
        return NSLocalizedString(key, comment: key)
    }
    
    //stringify
    open static func JSONStringify(_ value: AnyObject,prettyPrinted:Bool = false) -> String{
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        if JSONSerialization.isValidJSONObject(value) {
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
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
    
    //parse
    open static func parseJSON(_ dataStr: String) -> AnyObject{
        let data = (dataStr).data(using: String.Encoding.utf8)!
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
    
    
    
    open static func alert(_ ctrl : UIViewController! = nil, title : String = "알림", message : String, confirmTitle : String = "확인",cancelStr :String = "취소", isCancel: Bool = false, confirmHandler : @escaping (UIAlertAction) -> Void = {(_) in}, cancelHandler : @escaping (UIAlertAction) -> Void = {(_) in}) -> UIAlertController{
        let alert = UIAlertController(title:title,message:message, preferredStyle: UIAlertControllerStyle.alert)
        if isCancel{
            alert.addAction(UIAlertAction(title:cancelStr,style: .cancel,handler:cancelHandler))
        }
        alert.addAction(UIAlertAction(title:confirmTitle,style: .default,handler:confirmHandler))
        if ctrl != nil{
            ctrl.present(alert, animated: false, completion: {(_) in })
        }
        return alert
    }
    
    
    //이미지 리사이즈
    open static func imageResize (_ image:UIImage, sizeChange:CGSize)-> UIImage{
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    
    //확장자 구하기
    open static func getExt(_ url : String, defaultExt : ExtType = ExtType.jpeg) -> ExtType{
        if url.uppercased().range(of: "PNG") != nil{
            return ExtType.png
        }else if url.uppercased().range(of: "JPEG") != nil || url.uppercased().range(of: "JPG") != nil{
            return ExtType.jpeg
        }else {
            return defaultExt
        }
    }
    
    //이미지 데이터로 바꾸기
    open static func returnImageData(_ image : UIImage!, ext : ExtType) -> Data{
        var data : Data = Data()
        switch ext {
        case .jpeg:
            if let tmpData = UIImageJPEGRepresentation(image, 0.5){
                data = tmpData
            }
            break
        case .png:
            if let tmpData = UIImagePNGRepresentation(image){
                data = tmpData
            }
            break
        }
        return data
    }
    
    
    //base64 문자열 인코딩
    open static func base64Encoding(_ imageData : Data) -> String{
        let base64String = imageData.base64EncodedString(options: [])
        return base64String
    }
    
    //base64 문자열 디코딩
    open static func base64Decoding(_ base64String : String) -> Data{
        let imageData = Data(base64Encoded: base64String, options:NSData.Base64DecodingOptions(rawValue: 0))
        return imageData!
    }
    
    open static func convertStringToDictionary(_ data: Data) -> [String:AnyObject] {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
        } catch let error as NSError {
            print(error)
        }
        return Dictionary()
    }
    
    open static func priceComma(price: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        if let pointValue = numberFormatter.string(from: NSNumber(value: price)){
            return pointValue
        }else{
            return "0"
        }
    }
}
