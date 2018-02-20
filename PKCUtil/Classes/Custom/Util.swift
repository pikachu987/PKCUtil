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

import UIKit
import SafariServices

public class Util{
    
    // MARK: property
    
    
    /// language
    public static var language : String{
        return ((Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode) as? String) ?? "en"
    }
    
    /// locale
    public static var locale : String{
        return ((Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String) ?? "US"
    }
    
    /// version
    public static var nsVersion : String{
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "1.0"
    }
    
    /// uuid
    public static var deviceId : String{
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    
    
    // MARK: func
    
    /**
     window init
     - parameter bundle: Bundle
     - parameter window: UIWindow?
     - parameter storyboardName: String
     - parameter identifier: String
     */
    public static func initWindow(_ bundle: Bundle, window: UIWindow?, storyboardName: String = "Main", identifier: String = "ViewController"){
        let storyBoard : UIStoryboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        window?.rootViewController?.dismiss(animated: false, completion: nil)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    
    


    /**
     search ViewController
     - parameter handler: ((UIViewController?) -> Void)
     */
    public static func viewController(_ handler: ((UIViewController?) -> Void)){
        self.viewController(UIApplication.shared.keyWindow?.rootViewController, handler: handler)
    }
    
    /**
     search ViewController
     - parameter viewController: UIViewController?
     - parameter handler: ((UIViewController?) -> Void)
     */
    public static func viewController(_ viewController: UIViewController?, handler: ((UIViewController?) -> Void)){
        if let tabbarController = viewController as? UITabBarController{
            self.viewController(tabbarController.selectedViewController, handler: handler)
        }else if let navgationController = viewController as? UINavigationController{
            self.viewController(navgationController.visibleViewController, handler: handler)
        }else{
            handler(viewController)
        }
    }
    
    /**
     search TapBarController
     - parameter handler: ((UIViewController?) -> Void)
     */
    func tabController(_ handler: ((UIViewController?) -> Void)){
        self.tabController(UIApplication.shared.keyWindow?.rootViewController, handler: handler)
    }
    
    /**
     search TapBarController
     - parameter viewController: UIViewController?
     - parameter handler: ((UIViewController?) -> Void)
     */
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
    
    
    
    /**
     Open Safari URL
     - parameter path: String?
     - parameter viewController: UIViewController?
     */
    public static func openSafariUrl(_ path: String?, viewController: UIViewController? = nil){
        guard var urlPath = path else{ return }
        if urlPath == ""{ return }
        if !urlPath.hasPrefix("http://") && !urlPath.hasPrefix("https://"){
            urlPath = "http://\(urlPath)"
        }
        guard let url = URL(string: urlPath) else { return }
        if !UIApplication.shared.canOpenURL(url){ return }
        if #available(iOS 9.0, *) {
            let safariViewController = SFSafariViewController(url: url)
            if let viewController = viewController{
                viewController.present(safariViewController, animated: true, completion: nil)
            }else{
                self.viewController({ (viewController) in
                    viewController?.present(safariViewController, animated: true, completion: nil)
                })
            }
        } else {
            if #available(iOS 8.0, *) {
                UIApplication.shared.openURL(url)
            }else{
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    /**
     Open Default URL
     - parameter path: String?
     */
    public static func openDefaultUrl(_ path: String?){
        guard let urlPath = path, let url = URL(string: urlPath) else { return }
        if url.absoluteString == ""{ return }
        if !UIApplication.shared.canOpenURL(url){ return }
        if #available(iOS 8.0, *) {
            UIApplication.shared.openURL(url)
        }else{
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /**
     Open Default URL HTTP
     - parameter path: String?
     - parameter prefix: String
     */
    public static func openDefaultHttpUrl(_ path: String?, prefix: String = "http://"){
        guard let urlPath = path, var url = URL(string: urlPath) else { return }
        if url.absoluteString == ""{ return }
        if !url.absoluteString.hasPrefix("http://") && !url.absoluteString.hasPrefix("https://"){
            if let value = URL(string: "\(prefix)\(url.absoluteString)"){ url = value }
        }
        if !UIApplication.shared.canOpenURL(url){ return }
        if #available(iOS 8.0, *) {
            UIApplication.shared.openURL(url)
        }else{
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    
    
    
    
    
    /**
     Get Data Task
     - parameter path: String
     - parameter handler: ((Data) -> Void)
     - parameter errorHandler: (() -> Void)
     */
    public static func sessionDataTask(_ path: String, handler: @escaping ((Data) -> Void), errorHandler: (() -> Void)? = nil){
        if let url = URL(string: path){
            URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if error != nil{
                    errorHandler?()
                    return
                }
                guard let value = data else{
                    errorHandler?()
                    return
                }
                handler(value)
                }.resume()
        }else{
            errorHandler?()
        }
    }
    
    
    /**
     Between Distance
     - parameter latitude: Double
     - parameter longitude: Double
     - parameter currentLatitude: Double
     - parameter currentLongitude: Double
     */
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
