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
    public func textViewDefault(_ placeHolder: String){
        self.textColor = UIColor.color(204)
        self.text = placeHolder
    }
    public func textViewShouldBeginEditing(){
        if self.textColor == UIColor.color(204) {
            self.text = nil
            self.textColor = UIColor.black
        }
    }
    public func textViewDidBeginEditing(){
        
    }
    public func textViewDidEndEditing(_ placeHolder: String){
        if self.text.isEmpty {
            self.textColor = UIColor.color(204)
            self.text = placeHolder
        }else{
            self.textColor = UIColor.black
        }
    }
    public func textView(_ maxLength: Int = -1, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if self.text.characters.count > 0{
                self.textColor = UIColor.black
            }
        }
        if maxLength == -1{
            return true
        }else{
            return (self.text?.utf16.count ?? 0) + text.utf16.count - range.length <= maxLength
        }
    }
    
    
    
    
    public func resultTextViewSize() -> CGRect{
        let fixedWidth = self.frame.size.width
        self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = self.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        return newFrame
    }
}
