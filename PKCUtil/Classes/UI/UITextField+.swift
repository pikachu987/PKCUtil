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

public extension UITextField{
    
    
    // MARK: func
    
    /**
     maxLength
     - parameter maxLength: Int
     - parameter range: NSRange
     - parameter string: String
     - returns: Bool
     */
    public func maxLength(_ maxLength: Int = 200, range: NSRange, string: String) -> Bool{
        return maxLength == -1 ? true : ((self.text?.utf16.count ?? 0) + string.utf16.count - range.length) <= maxLength
    }
    
    /**
     makeToolBar
     - parameter target: Any?
     - parameter action: Selector
     - parameter color: UIColor
     - parameter selectString: String
     - parameter cancelString: String
     */
    public func toolBar(_ target: Any?, action: Selector, color: UIColor = UIColor(white: 224/255, alpha: 1), selectString: String = "Done", cancelString: String = "Cancel"){
        let toolBar =  UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = color
        
        toolBar.setItems([
            UIBarButtonItem(title: cancelString, style: .plain, target: self, action: #selector(self.cancelAction(_:))),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: selectString, style: .done, target: target, action: action)
            ], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        self.inputAccessoryView = toolBar
    }
    
    /// cancelAction
    @objc private func cancelAction(_ sender: UIBarButtonItem){
        self.resignFirstResponder()
    }
}
