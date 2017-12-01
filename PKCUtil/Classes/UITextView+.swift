//
//  UITextView+.swift
//  Pods
//
//  Created by guanho on 2017. 4. 21..
//
//

import Foundation
import UIKit


public extension UITextView{
    //maxLength
    public func textView(_ maxLength: Int = -1, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        return maxLength == -1 ? true : (self.text?.utf16.count ?? 0) + text.utf16.count - range.length <= maxLength
    }
    
    //텍스트뷰 사이즈 구하기
    public func resultTextViewSize() -> CGRect{
        let fixedWidth = self.frame.size.width
        self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = self.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        return newFrame
    }
}
