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

import Foundation
import UIKit

public extension UITableView{
    
    // MARK: func
    
    
    /**
     chat keyboard show
     - parameter view: UIView
     - parameter notification: Notification
     - parameter bottomConstraint: NSLayoutConstraint
     */
    public func chatKeyboardShow(_ view: UIView, notification: Notification, bottomConstraint: NSLayoutConstraint){
        guard let keyboardEndFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else{ return }
        guard let rawAnimation = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        
        let newBottomConstraint = UIScreen.main.bounds.size.height - keyboardEndFrame.origin.y
        let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        let rawAnimationCurve = rawAnimation.uint32Value << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        
        let oldYContentOffset = self.contentOffset.y
        let oldTableViewHeight = self.bounds.size.height
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.beginFromCurrentState, animationCurve], animations: {
            bottomConstraint.constant = newBottomConstraint
            view.layoutIfNeeded()
            let newTableViewHeight = self.bounds.size.height
            var newYContentOffset = oldYContentOffset - (newTableViewHeight - oldTableViewHeight)
            newYContentOffset = min(newYContentOffset, self.contentSize.height - newTableViewHeight)
            newYContentOffset = max(CGFloat(0), newYContentOffset)
            self.contentOffset = CGPoint(x: self.contentOffset.x, y: newYContentOffset)
        }, completion: nil)
    }
    
    
    /**
     chat keyboard hide
     - parameter view: UIView
     - parameter notification: Notification
     - parameter bottomConstraint: NSLayoutConstraint
     - parameter count: Int
     */
    public func chatKeyboardHideRow(_ view: UIView, notification: Notification, bottomConstraint: NSLayoutConstraint, count: Int){
        guard let rawAnimation = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        let newBottomConstraint: CGFloat = 0
        let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        let rawAnimationCurve = rawAnimation.uint32Value << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        
        let oldYContentOffset = self.contentOffset.y
        let oldTableViewHeight = self.bounds.size.height
        
        
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.beginFromCurrentState, animationCurve], animations: {
            bottomConstraint.constant = newBottomConstraint
            view.layoutIfNeeded()
            
            if floor(self.contentSize.height-self.bounds.height).int - 10 > floor(self.contentOffset.y).int{
                self.contentOffset = CGPoint(x: self.contentOffset.x, y: oldYContentOffset)
                let newTableViewHeight = self.bounds.size.height
                var newYContentOffset = oldYContentOffset - (newTableViewHeight - oldTableViewHeight)
                newYContentOffset = min(newYContentOffset, self.contentSize.height - newTableViewHeight)
                newYContentOffset = max(CGFloat(0), newYContentOffset)
                self.contentOffset = CGPoint(x: self.contentOffset.x, y: newYContentOffset)
            }else{
                if count >= 0{
                    self.scrollToRow(at: IndexPath(row: count, section: 0), at: .bottom, animated: false)
                }
            }
            
        }, completion: nil)
    }
    
    
    /**
     chat keyboard hide
     - parameter view: UIView
     - parameter notification: Notification
     - parameter bottomConstraint: NSLayoutConstraint
     - parameter count: Int
     */
    public func chatKeyboardHideSection(_ view: UIView, notification: Notification, bottomConstraint: NSLayoutConstraint, count: Int){
        guard let rawAnimation = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        let newBottomConstraint: CGFloat = 0
        let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        let rawAnimationCurve = rawAnimation.uint32Value << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        
        let oldYContentOffset = self.contentOffset.y
        let oldTableViewHeight = self.bounds.size.height
        
        
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.beginFromCurrentState, animationCurve], animations: {
            bottomConstraint.constant = newBottomConstraint
            view.layoutIfNeeded()
            
            if floor(self.contentSize.height-self.bounds.height).int - 10 > floor(self.contentOffset.y).int{
                self.contentOffset = CGPoint(x: self.contentOffset.x, y: oldYContentOffset)
                let newTableViewHeight = self.bounds.size.height
                var newYContentOffset = oldYContentOffset - (newTableViewHeight - oldTableViewHeight)
                newYContentOffset = min(newYContentOffset, self.contentSize.height - newTableViewHeight)
                newYContentOffset = max(CGFloat(0), newYContentOffset)
                self.contentOffset = CGPoint(x: self.contentOffset.x, y: newYContentOffset)
            }else{
                if count >= 0{
                    self.scrollToRow(at: IndexPath(row: 0, section: count), at: .bottom, animated: false)
                }
            }
            
        }, completion: nil)
    }
    
    
    
    
    
    
    /**
     chat view show
     - parameter view: UIView
     - parameter height: CGFloat
     - parameter bottomConstraint: NSLayoutConstraint
     */
    public func chatViewShow(_ view: UIView, bottomConstraint: NSLayoutConstraint){
        let oldYContentOffset = self.contentOffset.y
        let oldTableViewHeight = self.bounds.size.height
        UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState], animations: {
            view.layoutIfNeeded()
            let newTableViewHeight = self.bounds.size.height
            var newYContentOffset = oldYContentOffset - (newTableViewHeight - oldTableViewHeight)
            newYContentOffset = min(newYContentOffset, self.contentSize.height - newTableViewHeight)
            newYContentOffset = max(CGFloat(0), newYContentOffset)
            self.contentOffset = CGPoint(x: self.contentOffset.x, y: newYContentOffset)
        }, completion: nil)
    }
    
    
    /**
     chat view hide
     - parameter view: UIView
     - parameter height: CGFloat
     - parameter bottomConstraint: NSLayoutConstraint
     - parameter count: Int
     */
    public func chatViewHideRow(_ view: UIView, bottomConstraint: NSLayoutConstraint, count: Int){
        let oldYContentOffset = self.contentOffset.y
        let oldTableViewHeight = self.bounds.size.height
        UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState], animations: {
            view.layoutIfNeeded()
            if floor(self.contentSize.height-self.bounds.height).int - 10 > floor(self.contentOffset.y).int{
                self.contentOffset = CGPoint(x: self.contentOffset.x, y: oldYContentOffset)
                let newTableViewHeight = self.bounds.size.height
                var newYContentOffset = oldYContentOffset - (newTableViewHeight - oldTableViewHeight)
                newYContentOffset = min(newYContentOffset, self.contentSize.height - newTableViewHeight)
                newYContentOffset = max(CGFloat(0), newYContentOffset)
                self.contentOffset = CGPoint(x: self.contentOffset.x, y: newYContentOffset)
            }else{
                if count >= 0{
                    self.scrollToRow(at: IndexPath(row: count, section: 0), at: .bottom, animated: false)
                }
            }
        }, completion: nil)
    }
    
    /**
     chat view hide
     - parameter view: UIView
     - parameter height: CGFloat
     - parameter bottomConstraint: NSLayoutConstraint
     - parameter count: Int
     */
    public func chatViewHideSection(_ view: UIView, bottomConstraint: NSLayoutConstraint, count: Int){
        let oldYContentOffset = self.contentOffset.y
        let oldTableViewHeight = self.bounds.size.height
        UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState], animations: {
            view.layoutIfNeeded()
            if floor(self.contentSize.height-self.bounds.height).int - 10 > floor(self.contentOffset.y).int{
                self.contentOffset = CGPoint(x: self.contentOffset.x, y: oldYContentOffset)
                let newTableViewHeight = self.bounds.size.height
                var newYContentOffset = oldYContentOffset - (newTableViewHeight - oldTableViewHeight)
                newYContentOffset = min(newYContentOffset, self.contentSize.height - newTableViewHeight)
                newYContentOffset = max(CGFloat(0), newYContentOffset)
                self.contentOffset = CGPoint(x: self.contentOffset.x, y: newYContentOffset)
            }else{
                if count >= 0{
                    self.scrollToRow(at: IndexPath(row: 0, section: count), at: .bottom, animated: false)
                }
            }
        }, completion: nil)
    }
    
    
    
    
    
    
    /**
     chat keyboard dynamic Height
     - parameter value: CGFloat
     */
    
    public func chatKeyboardDynamicHeight(_ value: CGFloat, animated: Bool = false){
        let offsetY = self.contentOffset.y
        self.setContentOffset(CGPoint(x: self.contentOffset.x, y: offsetY-value), animated: animated)
    }
    
}
