//
//  UITextField.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import UIKit


fileprivate class ActionSingleton{
    var editingChangedEventDict: [UIView : () -> ()] = Dictionary()
    static let shared = ActionSingleton()
}

public extension UITextField{
    private func addAction(action: @escaping ((Void) -> Void)){
        let actionSingleton = ActionSingleton.shared
        actionSingleton.editingChangedEventDict.updateValue( action, forKey: self)
        self.addTarget(self, action: #selector(self.editingChangedAction), for: .editingChanged)
    }
    
    public func maxLength(_ maxLength : Int){
        self.addAction {
            guard let count =  self.text?.characters.count else{
                return
            }
            if count > maxLength {
                self.deleteBackward()
            }
        }
    }
    
    @objc fileprivate func editingChangedAction(_ sender: UITextField, maxLength: Int){
        let actionSingleton = ActionSingleton.shared
        actionSingleton.editingChangedEventDict[self]?()
    }

    public func setLeftPadding(_ padding : CGFloat = 10){
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftViewMode = UITextFieldViewMode.always
    }
    public func setRightPadding(_ padding : CGFloat = 10){
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.rightViewMode = UITextFieldViewMode.always
    }
}




public extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}
