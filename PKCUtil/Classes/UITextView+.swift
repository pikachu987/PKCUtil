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
    //텍스트뷰 기본 placeholder
    public func textViewDefault(_ placeHolder: String){
        self.textColor = UIColor.color(204)
        self.text = placeHolder
    }
    //텍스트뷰 딜리게이트 메서드에서 사용 placeholder
    public func textViewShouldBeginEditing(){
        if self.textColor == UIColor.color(204) {
            self.text = nil
            self.textColor = UIColor.black
        }
    }
    //텍스트뷰 딜리게이트 메서드에서 사용 placeholder
    public func textViewDidBeginEditing(){
        
    }
    //텍스트뷰 딜리게이트 메서드에서 사용 placeholder
    public func textViewDidEndEditing(_ placeHolder: String){
        if self.text.isEmpty {
            self.textColor = UIColor.color(204)
            self.text = placeHolder
        }else{
            self.textColor = UIColor.black
        }
    }
    //텍스트뷰 딜리게이트 메서드에서 사용 placeholder과 maxLength
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
