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
    
    // MARK: var
    
    /**
     contentViewController - textView
     - returns: UITextView?
     */
    public var textView: UITextView?{
        guard let contentViewController = self.value(forKey: "contentViewController") as? UIViewController else{ return nil }
        if contentViewController.view == nil { return nil }
        guard let textView = contentViewController.view.subviews.compactMap({ $0 as? UITextView }).first else{ return nil }
        return textView
    }
    
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
        self.addAction(UIAlertAction(title: title, style: style, handler: { [weak self] (_) in
            handler?(self ?? UIAlertController())
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
     Make TextView
     - parameter handler: ((UITextView) -> Void)?
     - returns: UIAlertController
     */
    @discardableResult
    public func appendTextView(_ handler: ((UITextView) -> Void)? = nil) -> UIAlertController{
        let textViewController = UIViewController()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor(white: 210/255, alpha: 1).cgColor
        textView.layer.borderWidth = 1
        handler?(textView)
        view.addSubview(textView)
        
        let view_constraint_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[view]-6-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": textView])
        let view_constraint_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-6-[view]-6-|", options: NSLayoutFormatOptions.alignAllLeading, metrics: nil, views: ["view": textView])
        view.addConstraints(view_constraint_H)
        view.addConstraints(view_constraint_V)
        textViewController.view = view
        textViewController.preferredContentSize.height = 100
        self.setValue(textViewController, forKey: "contentViewController")
        
        return self
    }
    
    
    
    
    /**
     Show UIAlertController
     - parameter viewController: UIViewController
     - returns: UIAlertController
     */
    @discardableResult
    public func show(_ viewController: UIViewController?) -> UIAlertController{
        DispatchQueue.main.async {
            viewController?.present(self, animated: true, completion: nil)
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
