//
//  UITextField.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import UIKit

//액션을 저장하는 싱글턴
fileprivate class ActionSingleton{
    var editingChangedEventDict: [UIView : () -> ()] = Dictionary()
    static let shared = ActionSingleton()
}

public extension UITextField{
    //액션 추가
    private func addAction(action: @escaping (() -> Void)){
        let actionSingleton = ActionSingleton.shared
        actionSingleton.editingChangedEventDict.updateValue( action, forKey: self)
        self.addTarget(self, action: #selector(self.editingChangedAction), for: .editingChanged)
    }
    //textField 최대 길이 제한
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
    
    
    //왼쪽 여백 추가
    public func setLeftPadding(_ padding : CGFloat = 10){
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftViewMode = UITextFieldViewMode.always
    }
    //오른쪽 여백 추가
    public func setRightPadding(_ padding : CGFloat = 10){
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.rightViewMode = UITextFieldViewMode.always
    }
}




//public extension UITextField{
//    @IBInspectable var placeHolderColor: UIColor? {
//        get {
//            return self.placeHolderColor
//        }
//        set {
//            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
//        }
//    }
//}
