//
//  PKCUtil.swift
//  PKCUtil
//
//  Created by guanho on 2016. 4. 6..
//  Copyright © 2016년 guanho. All rights reserved.
//

import UIKit
import SafariServices

public class PKCUtil{
    //언어
    public static var language : String{
        if let value = (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode) as? String{
            return value
        }else{
            return "en"
        }
        
    }
    
    //지역
    public static var locale : String{
        if let value = (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String{
            return value
        }else{
            return "US"
        }
    }
    
    //현재 버전
    public static var nsVersion : String{
        if let value = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String{
            return value
        }else{
            return "1.0"
        }
    }
    
    //디바이스 uuid
    public static var deviceId : String{
        if let value = UIDevice.current.identifierForVendor?.uuidString{
            return value
        }else{
            return ""
        }
    }
    
    //윈도우 초기화
    public static func initWindow(_ bundle: Bundle, window: UIWindow?, storyboardName: String = "Main", identifier: String = "ViewController"){
        let storyBoard : UIStoryboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        window?.rootViewController?.dismiss(animated: false, completion: nil)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    
    
    
    
    // MARK: Reg
    
    //이메일
    public static func isValidEmail(_ string: String) -> Bool {
        let regEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return emailTest.evaluate(with: string)
    }
    
    //페이지
    public static func isValidateUrl (_ string: String) -> Bool {
        let regEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: string)
    }
    
    //한글인지
    public static func isValidateKorean(_ string: String) -> Bool{
        let regEx = ".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: string)
    }



    //뷰컨 찾기
    public static func viewController(_ handler: ((UIViewController?) -> Void)){
        self.viewController(UIApplication.shared.keyWindow?.rootViewController, handler: handler)
    }
    
    public static func viewController(_ viewController: UIViewController?, handler: ((UIViewController?) -> Void)){
        if let tabbarController = viewController as? UITabBarController{
            self.viewController(tabbarController.selectedViewController, handler: handler)
        }else if let navgationController = viewController as? UINavigationController{
            self.viewController(navgationController.visibleViewController, handler: handler)
        }else{
            handler(viewController)
        }
    }
    
    //탭컨트롤러 찾기
    func tabController(_ handler: ((UIViewController?) -> Void)){
        self.tabController(UIApplication.shared.keyWindow?.rootViewController, handler: handler)
    }
    
    private func tabController(_ viewController: UIViewController?, handler: ((UIViewController?) -> Void)){
        if let navVC = viewController as? UINavigationController{
            self.tabController(navVC.visibleViewController, handler: handler)
        }else if let tabBarVC = viewController as? UITabBarController{
            handler(tabBarVC)
        }else if let viewController = viewController{
            if viewController.presentingViewController != nil{
                self.tabController(viewController.presentingViewController, handler: handler)
            }else{
                self.tabController(viewController.presentedViewController, handler: handler)
            }
        }else{
            handler(nil)
        }
    }
    
    
    
    
    //오픈 사파리 URL
    public static func openSafariUrl(_ path: String?){
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
            self.viewController({ (viewController) in
                viewController?.present(safariViewController, animated: true, completion: nil)
            })
        } else {
            if #available(iOS 8.0, *) {
                UIApplication.shared.openURL(url)
            }else{
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    //기본 브라우져로 열기
    public static func openDefaultUrl(_ path: String?){
        guard let urlPath = path, let url = URL(string: urlPath) else {
            return
        }
        if url.absoluteString == ""{
            return
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
    
    //기본 브라우져로 열기 http확인
    public static func openDefaultHttpUrl(_ path: String?, prefix: String = "http://"){
        guard let urlPath = path, var url = URL(string: urlPath) else {
            return
        }
        if url.absoluteString == ""{
            return
        }
        if !url.absoluteString.hasPrefix("http://") && !url.absoluteString.hasPrefix("https://"){
            if let value = URL(string: "\(prefix)\(url.absoluteString)"){ url = value }
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
    public static func sessionDataTask(_ path: String, handler: @escaping ((Data) -> Void)){
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
    public static func getBetweenDistance(latitude : Double, longitude: Double, currentLatitude: Double, currentLongitude: Double) -> String{
        let currentRadiansX = (currentLatitude*Double.pi)/180
        let currentRadiansY = (currentLongitude*Double.pi)/180
        let radiansX = (latitude*Double.pi)/180
        let radiansY = (longitude*Double.pi)/180
        let distanceTmp = 6371*acos(cos(currentRadiansX)*cos(radiansX)*cos(radiansY-currentRadiansY)+sin(currentRadiansX)*sin(radiansX))
        let strArray = "\(distanceTmp)".components(separatedBy: ".")
        return strArray[0]
    }
}
