//
//  UIAlertController+.swift
//  PKCUtil
//
//  Created by docfriends on 2017. 11. 14..
//

import UIKit

public extension UIAlertController{
    
    
    //alert
    
    
    @discardableResult
    public static func alert(_ title: String = "", message: String) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alertController
    }
    
    
    @discardableResult
    public static func alertCancel(_ title: String = "", message: String, cancelString: String = kSTRING.TITLE.CANCEL, cancelHandler: (() -> Void)? = nil) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: cancelString, style: .cancel, handler: { (_) in
            cancelHandler?()
        }))
        return alertController
    }
    
    @discardableResult
    public static func alertConfirm(_ title: String = "", message: String, defaultString: String = kSTRING.TITLE.CONFIRM, defaultHandler: (() -> Void)? = nil) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: defaultString, style: .default, handler: { (_) in
            defaultHandler?()
        }))
        return alertController
    }
    
    
    @discardableResult
    public static func alert(_ title: String = "", message: String, defaultString: String = kSTRING.TITLE.CONFIRM, cancelString: String = kSTRING.TITLE.CANCEL, defaultHandler: @escaping (() -> Void), cancelHandler: (() -> Void)? = nil) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: defaultString, style: .default, handler: { (_) in
            defaultHandler()
        }))
        alertController.addAction(UIAlertAction(title: cancelString, style: .cancel, handler: { (_) in
            cancelHandler?()
        }))
        return alertController
    }
    
    
    
    
    
    
    
    //sheet
    
    @discardableResult
    public static func sheet(_ title: String = "", message: String) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        return alertController
    }
    
    @discardableResult
    public static func sheetCancel(_ title: String = "", message: String, cancelString: String = kSTRING.TITLE.CANCEL, cancelHandler: (() -> Void)? = nil) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: cancelString, style: .cancel, handler: { (_) in
            cancelHandler?()
        }))
        return alertController
    }
    
    @discardableResult
    public static func sheetConfirm(_ title: String = "", message: String, defaultString: String = kSTRING.TITLE.CONFIRM, defaultHandler: (() -> Void)? = nil) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: defaultString, style: .default, handler: { (_) in
            defaultHandler?()
        }))
        return alertController
    }
    
    
    @discardableResult
    public static func sheet(_ title: String = "", message: String, defaultString: String = kSTRING.TITLE.CONFIRM, cancelString: String = kSTRING.TITLE.CANCEL, defaultHandler: @escaping (() -> Void), cancelHandler: (() -> Void)? = nil) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: defaultString, style: .default, handler: { (_) in
            defaultHandler()
        }))
        alertController.addAction(UIAlertAction(title: cancelString, style: .cancel, handler: { (_) in
            cancelHandler?()
        }))
        return alertController
    }
    
    
    
    
    
    //action
    
    private func action(_ title: String, style: UIAlertActionStyle, handler: (() -> Void)? = nil) -> UIAlertController{
        self.addAction(UIAlertAction(title: title, style: .default, handler: { (_) in
            handler?()
        }))
        return self
    }
    
    @discardableResult
    public func add(_ title: String, style: UIAlertActionStyle = .default, handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(title, style: style, handler: handler)
    }
    
    @discardableResult
    public func confirm(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.CONFIRM, style: .default, handler: handler)
    }
    
    @discardableResult
    public func cancel(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.CANCEL, style: .cancel, handler: handler)
    }
    
    @discardableResult
    public func destructive(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.DELETE, style: .destructive, handler: handler)
    }
    
    @discardableResult
    public func yes(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.YES, style: .default, handler: handler)
    }
    
    @discardableResult
    public func move(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.MOVE, style: .default, handler: handler)
    }
    
    @discardableResult
    public func genderM(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.GENDERM, style: .default, handler: handler)
    }
    
    @discardableResult
    public func genderF(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.GENDERF, style: .default, handler: handler)
    }
    
    @discardableResult
    public func complete(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.COMPLETE, style: .default, handler: handler)
    }
    
    @discardableResult
    public func setting(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.SETTING, style: .default, handler: handler)
    }
    
    @discardableResult
    public func start(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.START, style: .default, handler: handler)
    }
    
    @discardableResult
    public func exit(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.EXIT, style: .default, handler: handler)
    }
    
    @discardableResult
    public func save(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.SAVE, style: .default, handler: handler)
    }
    
    @discardableResult
    public func share(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.SHARE, style: .default, handler: handler)
    }
    
    @discardableResult
    public func camera(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.CAMERA, style: .default, handler: handler)
    }
    
    @discardableResult
    public func gallery(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.GALLERY, style: .default, handler: handler)
    }
    
    @discardableResult
    public func search(_ handler: (() -> Void)? = nil) -> UIAlertController{
        return self.action(kSTRING.TITLE.SEARCH, style: .default, handler: handler)
    }
    
    
    
    
    
    
    //show
    
    @discardableResult
    public func show(_ viewController: UIViewController) -> UIAlertController{
        viewController.present(self, animated: true, completion: nil)
        return self
    }
    
    @discardableResult
    public func show() -> UIAlertController{
        PKCUtil.viewController { (viewController) in
            viewController?.present(self, animated: true, completion: nil)
        }
        return self
    }
    
    
    
    
    
    
    
    
    //permission
    
    //권한 denied
    @discardableResult
    public static func permissionDenied(_ message: String, doMove: String = kSTRING.TITLE.DO.MOVE, cancel: String = kSTRING.TITLE.CANCEL) -> UIAlertController{
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: doMove, style: .default, handler: { (_) in
            guard let bundleIdentifier = Bundle.main.bundleIdentifier else{
                return
            }
            guard let url = URL(string: "\(UIApplicationOpenSettingsURLString)\(bundleIdentifier)") else{
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
        }))
        alertController.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
        return alertController
    }
    
    @discardableResult
    public func addSetting(_ doMove: String = kSTRING.TITLE.DO.MOVE) -> UIAlertController{
        self.addAction(UIAlertAction(title: doMove, style: .default, handler: { (_) in
            guard let bundleIdentifier = Bundle.main.bundleIdentifier else{
                return
            }
            guard let url = URL(string: "\(UIApplicationOpenSettingsURLString)\(bundleIdentifier)") else{
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
        }))
        return self
    }
    
}
