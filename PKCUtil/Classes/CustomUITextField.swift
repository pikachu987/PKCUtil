//
//  UITextField.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

extension UITextField{
    func setLeftPadding(_ padding : CGFloat = 10){
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftViewMode = UITextFieldViewMode.always
    }
    func setRightPadding(_ padding : CGFloat = 10){
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.rightViewMode = UITextFieldViewMode.always
    }
    func maxLength(_ maxLength : Int){
        self.addAction(.editingChanged) {
            if (self.text?.characters.count > maxLength) {
                self.deleteBackward()
            }
        }
    }
}
