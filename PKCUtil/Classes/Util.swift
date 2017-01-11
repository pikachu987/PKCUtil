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
    //언어
    static var language : String = ((Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode) as? String)!
    //현재 버전
    static let nsVersion : String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    //디바이스id
    static let deviceId : String = UIDevice.current.identifierForVendor!.uuidString
    //스크린 사이즈
    static let screenSize: CGRect = UIScreen.main.bounds
    
    //다국어지원
    static func lang(_ key : String) -> String{
        return NSLocalizedString(key, comment: key)
    }
    
    //stringify
    static func JSONStringify(_ value: AnyObject,prettyPrinted:Bool = false) -> String{
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
    static func parseJSON(_ dataStr: String) -> AnyObject{
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
    
    
    
    static func alert(_ ctrl : UIViewController! = nil, title : String = "알림", message : String, confirmTitle : String = "확인",cancelStr :String = "취소", isCancel: Bool = false, confirmHandler : @escaping (UIAlertAction) -> Void = {(_) in}, cancelHandler : @escaping (UIAlertAction) -> Void = {(_) in}) -> UIAlertController{
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
    static func imageResize (_ image:UIImage, sizeChange:CGSize)-> UIImage{
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    
    //확장자 구하기
    static func getExt(_ url : String, defaultExt : ExtType = ExtType.jpeg) -> ExtType{
        if url.uppercased().range(of: "PNG") != nil{
            return ExtType.png
        }else if url.uppercased().range(of: "JPEG") != nil || url.uppercased().range(of: "JPG") != nil{
            return ExtType.jpeg
        }else {
            return defaultExt
        }
    }
    
    //이미지 데이터로 바꾸기
    static func returnImageData(_ image : UIImage!, ext : ExtType) -> Data{
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
    static func base64Encoding(_ imageData : Data) -> String{
        let base64String = imageData.base64EncodedString(options: [])
        return base64String
    }
    
    //base64 문자열 디코딩
    static func base64Decoding(_ base64String : String) -> Data{
        let imageData = Data(base64Encoded: base64String, options:NSData.Base64DecodingOptions(rawValue: 0))
        return imageData!
    }
    
    static func convertStringToDictionary(_ data: Data) -> [String:AnyObject] {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
        } catch let error as NSError {
            print(error)
        }
        return Dictionary()
    }
}
