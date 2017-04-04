//
//  PKCAlert.swift
//  Pods
//
//  Created by guanho on 2017. 3. 31..
//
//

import UIKit

public class PKCAlert: NSObject {
    public static let shared = PKCAlert()
    
    private override init() {
        
    }
    
    func defaultAlert(_ title: String = "", message: String, ok: String = "확인", handler: ((Void) -> Void)? = nil) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.createAction(alertController, title: ok, style: .cancel, handler: handler)
        return alertController
    }
    
    func confirmAlert(_ title: String = "", message: String, ok: String = "확인", cancel: String = "취소", handler: ((Void) -> Void)? = nil) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.createAction(alertController, title: ok, style: .default, handler: handler)
        self.createAction(alertController, title: cancel, style: .cancel)
        return alertController
    }
    
    func sheetAlert(_ title: String = "", message: String, array: [(String, Any)], handler: (((String, Any)) -> Void)? = nil) -> UIAlertController{
        let alertController = self.createSheetController(title, message: message)
        for element in array{
            alertController.addAction(UIAlertAction(title: element.0, style: .default, handler: { (_) in
                handler?(element)
            }))
        }
        return alertController
    }
    
    func createSheetController(_ title: String = "", message: String) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        return alertController
    }
    
    func createAction(_ alertController: UIAlertController, title: String, style: UIAlertActionStyle = .default, handler: ((Void) -> Void)? = nil){
        let alertAction = UIAlertAction(title: title, style: style) { (_) in
            handler?()
        }
        alertController.addAction(alertAction)
    }
}

