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

public extension UIAlertController{
    
    // MARK: func
    
    /**
     Make UIAlertController .alert
     - parameter title: String?
     - parameter message: String?
     - returns: UIAlertController
     */
    @discardableResult
    public static func alert(_ title: String? = "", message: String?) -> UIAlertController{
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    
    /**
     Make UIAlertController .alert
     - parameter title: String?
     - parameter message: String?
     - parameter cancelString: String
     - parameter cancelHandler: ((UIAlertController) -> Void)? = nil)
     - returns: UIAlertController
     */
    @discardableResult
    public static func alert(_ title: String? = "", message: String?, cancelString: String, cancelHandler: ((UIAlertController) -> Void)? = nil) -> UIAlertController{
        return UIAlertController
            .alert(title, message: message)
            .cancel(cancelString, handler: cancelHandler)
    }
    
    
    /**
     Make UIAlertController .alert
     - parameter title: String?
     - parameter message: String?
     - parameter defaultString: String
     - parameter defaultHandler: ((UIAlertController) -> Void)? = nil)
     - returns: UIAlertController
     */
    @discardableResult
    public static func alert(_ title: String? = "", message: String?, defaultString: String, defaultHandler: ((UIAlertController) -> Void)? = nil) -> UIAlertController{
        return UIAlertController
            .alert(title, message: message)
            .add(defaultString, handler: defaultHandler)
    }
    
    /**
     Make UIAlertController .alert
     - parameter title: String?
     - parameter message: String?
     - parameter defaultString: String
     - parameter cancelString: String
     - parameter defaultHandler: ((UIAlertController) -> Void)? = nil)
     - parameter cancelHandler: ((UIAlertController) -> Void)? = nil)
     - returns: UIAlertController
     */
    @discardableResult
    public static func alert(_ title: String? = "", message: String?, defaultString: String, cancelString: String, defaultHandler: @escaping ((UIAlertController) -> Void), cancelHandler: ((UIAlertController) -> Void)? = nil) -> UIAlertController{
        return UIAlertController
            .alert(title, message: message)
            .cancel(cancelString, handler: cancelHandler)
            .add(defaultString, handler: defaultHandler)
    }
    
    
    
    
    
    
    /**
     Make UIAlertController .actionSheet
     - parameter title: String?
     - parameter message: String?
     - returns: UIAlertController
     */
    @discardableResult
    public static func sheet(_ title: String? = "", message: String?) -> UIAlertController{
        return UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }
    
    /**
     Make UIAlertController .actionSheet
     - parameter title: String?
     - parameter message: String?
     - parameter cancelString: String
     - parameter cancelHandler: ((UIAlertController) -> Void)? = nil)
     - returns: UIAlertController
     */
    @discardableResult
    public static func sheet(_ title: String? = "", message: String?, cancelString: String, cancelHandler: ((UIAlertController) -> Void)? = nil) -> UIAlertController{
        return UIAlertController
            .sheet(title, message: message)
            .cancel(cancelString, handler: cancelHandler)
    }
    
    
    /**
     Make UIAlertController .actionSheet
     - parameter title: String?
     - parameter message: String?
     - parameter defaultString: String
     - parameter defaultHandler: ((UIAlertController) -> Void)? = nil)
     - returns: UIAlertController
     */
    @discardableResult
    public static func sheet(_ title: String? = "", message: String?, defaultString: String, defaultHandler: ((UIAlertController) -> Void)? = nil) -> UIAlertController{
        return UIAlertController
            .sheet(title, message: message)
            .add(defaultString, handler: defaultHandler)
    }
    
    
    /**
     Make UIAlertController .actionSheet
     - parameter title: String?
     - parameter message: String?
     - parameter defaultString: String
     - parameter cancelString: String
     - parameter defaultHandler: ((UIAlertController) -> Void)? = nil)
     - parameter cancelHandler: ((UIAlertController) -> Void)? = nil)
     - returns: UIAlertController
     */
    @discardableResult
    public static func sheet(_ title: String? = "", message: String?, defaultString: String, cancelString: String, defaultHandler: @escaping ((UIAlertController) -> Void), cancelHandler: ((UIAlertController) -> Void)? = nil) -> UIAlertController{
        return UIAlertController
            .sheet(title, message: message)
            .cancel(cancelString, handler: cancelHandler)
            .add(defaultString, handler: defaultHandler)
    }
    
    
    
    /**
     Make Action
     - parameter title: String?
     - parameter style: UIAlertActionStyle
     - parameter handler: ((UIAlertController) -> Void)? = nil)
     - returns: UIAlertController
     */
    private func action(_ title: String?, style: UIAlertActionStyle, handler: ((UIAlertController) -> Void)? = nil) -> UIAlertController{
        self.addAction(UIAlertAction(title: title, style: style, handler: { (_) in
            handler?(self)
        }))
        return self
    }
    
    
    /**
     Make Default Action
     - parameter title: String?
     - parameter handler: ((UIAlertController) -> Void)? = nil)
     - returns: UIAlertController
     */
    @discardableResult
    public func add(_ title: String?, handler: ((UIAlertController) -> Void)? = nil) -> UIAlertController{
        return self.action(title, style: .default, handler: handler)
    }
    
    
    /**
     Make Cancel Action
     - parameter title: String?
     - parameter handler: ((UIAlertController) -> Void)? = nil)
     - returns: UIAlertController
     */
    @discardableResult
    public func cancel(_ title: String?, handler: ((UIAlertController) -> Void)? = nil) -> UIAlertController{
        return self.action(title, style: .cancel, handler: handler)
    }
    
    
    /**
     Make Destructive Action
     - parameter title: String?
     - parameter handler: ((UIAlertController) -> Void)? = nil)
     - returns: UIAlertController
     */
    @discardableResult
    public func destructive(_ title: String?, handler: ((UIAlertController) -> Void)? = nil) -> UIAlertController{
        return self.action(title, style: .destructive, handler: handler)
    }
    
    
    
    
    /**
     Make TextField
     - parameter handler: ((UITextField) -> Void)?
     - returns: UIAlertController
     */
    @discardableResult
    public func appendTextField(_ handler: ((UITextField) -> Void)? = nil) -> UIAlertController{
        self.addTextField { (textField) in
            handler?(textField)
        }
        return self
    }
    
    
    
    
    
    
    /**
     Show UIAlertController
     - parameter viewController: UIViewController
     - returns: UIAlertController
     */
    @discardableResult
    public func show(_ viewController: UIViewController) -> UIAlertController{
        DispatchQueue.main.async {
            viewController.present(self, animated: true, completion: nil)
        }
        return self
    }
    
    
    /**
     Show UIAlertController
     - returns: UIAlertController
     */
    @discardableResult
    public func show() -> UIAlertController{
        Util.viewController { (viewController) in
            DispatchQueue.main.async {
                viewController?.present(self, animated: true, completion: nil)
            }
        }
        return self
    }
    
    
    
    
    
    
    
    
    /**
     Permission AlertAction
     - parameter title: String
     - parameter handler: (() -> Void)? = nil
     - returns: UIAlertController
     */
    @discardableResult
    public func openSetting(_ title: String, handler: (() -> Void)? = nil) -> UIAlertController{
        self.addAction(UIAlertAction(title: title, style: .default, handler: { (_) in
            handler?()
            guard let bundleIdentifier = Bundle.main.bundleIdentifier else{ return }
            guard let url = URL(string: "\(UIApplicationOpenSettingsURLString)\(bundleIdentifier)") else{ return }
            if !UIApplication.shared.canOpenURL(url){ return }
            
            if #available(iOS 8.0, *) {
                UIApplication.shared.openURL(url)
            }else{
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        return self
    }
    
}
