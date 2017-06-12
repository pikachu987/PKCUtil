//
//  PKCUtil.swift
//  PKCUtil
//
//  Created by guanho on 2016. 4. 6..
//  Copyright © 2016년 guanho. All rights reserved.
//

import UIKit
import SafariServices

open class PKCUtil{
    //언어
    open static var language : String{
        if let value = (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode) as? String{
            return value
        }else{
            return "en"
        }
    }
    
    //지역
    open static var locale : String{
        if let value = (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String{
            return value
        }else{
            return "US"
        }
    }
    
    //현재 버전
    open static var nsVersion : String{
        if let value = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String{
            return value
        }else{
            return "1.0"
        }
    }
    
    //디바이스 uuid
    open static var deviceId : String{
        if let value = UIDevice.current.identifierForVendor?.uuidString{
            return value
        }else{
            return ""
        }
    }
    
    //윈도우 초기화
    open static func initWindow(_ bundle: Bundle, window: UIWindow?, storyboardName: String = "Main", identifier: String = "ViewController"){
        let storyBoard : UIStoryboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        window?.rootViewController?.dismiss(animated: false, completion: nil)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    
    // MARK: Reg
    
    //이메일
    open static func isValidEmail(_ string: String) -> Bool {
        let regEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return emailTest.evaluate(with: string)
    }
    
    //페이지
    open static func isValidateUrl (_ string: String) -> Bool {
        let regEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: string)
    }
    
    //한글인지
    open static func isValidateKorean(_ string: String) -> Bool{
        let regEx = ".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: string)
    }

    //SF사파리
    open static func openSafari(_ path: String?, window: UIWindow?){
        guard var urlPath = path else{
            return
        }
        if urlPath == ""{
            return
        }
        if !urlPath.hasPrefix("http://") && !urlPath.hasPrefix("https://"){
            urlPath = "http://\(urlPath)"
        }
        guard let url = URL(string: urlPath) else {
            return
        }
        if !UIApplication.shared.canOpenURL(url){
            return
        }
        if #available(iOS 9.0, *) {
            let safariViewController = SFSafariViewController(url: url)
            PKCUtil.checkViewController(window?.rootViewController) { (viewController) in
                viewController?.present(safariViewController, animated: true, completion: nil)
            }
        } else {
            PKCUtil.openUrl(url)
        }
    }


    private static func checkViewController(_ viewController: UIViewController?, handler: ((UIViewController?) -> Void)){
        if let navVC = viewController as? UINavigationController{
            PKCUtil.checkViewController(navVC.visibleViewController, handler: handler)
        }else if let tabBarVC = viewController as? UITabBarController{
            PKCUtil.checkViewController(tabBarVC.selectedViewController, handler: handler)
        }else{
            handler(viewController)
        }
    }


    //기본 브라우져로 열기
    open static func openUrlPath(_ path: String?){
        guard let urlPath = path, let url = URL(string: urlPath) else {
            return
        }
        self.openUrl(url)
    }
    
    //기본 브라우져로 열기
    open static func openUrl(_ url: URL){
        var url = url
        if url.absoluteString == ""{
            return
        }
        if !url.absoluteString.hasPrefix("http://") && !url.absoluteString.hasPrefix("https://"){
            if let value = URL(string: "http://\(url.absoluteString)"){
                url = value
            }
        }
        if !UIApplication.shared.canOpenURL(url){
            return
        }
        if #available(iOS 8.0, *) {
            UIApplication.shared.openURL(url)
        }else{
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    //데이터 가져오기
    open static func sessionDataTask(_ path: String, handler: @escaping ((Data) -> Void)){
        if let url = URL(string: path){
            URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if error != nil{
                    return
                }
                guard let value = data else{
                    return
                }
                handler(value)
                }.resume()
        }
    }
    
    
    //좌표로 거리 계산
    open static func getBetweenDistance(latitude : Double, longitude: Double, currentLatitude: Double, currentLongitude: Double) -> String{
        let currentRadiansX = (currentLatitude*Double.pi)/180
        let currentRadiansY = (currentLongitude*Double.pi)/180
        let radiansX = (latitude*Double.pi)/180
        let radiansY = (longitude*Double.pi)/180
        let distanceTmp = 6371*acos(cos(currentRadiansX)*cos(radiansX)*cos(radiansY-currentRadiansY)+sin(currentRadiansX)*sin(radiansX))
        let strArray = "\(distanceTmp)".components(separatedBy: ".")
        return strArray[0]
    }
}
