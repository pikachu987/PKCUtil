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

public extension UIScrollView {
    
    // MARK: property
    
    /// delta Offset Y
    public var deltaOffsetY: CGFloat{
        let currentOffset = self.contentOffset.y
        let maximumOffset = self.contentSize.height - self.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        return deltaOffset
    }
    
    /// delta Offset X
    public var deltaOffsetX: CGFloat{
        let currentOffset = self.contentOffset.x
        let maximumOffset = self.contentSize.width - self.frame.size.width
        let deltaOffset = maximumOffset - currentOffset
        return deltaOffset
    }
    
    /**
     scroll To Top
     - parameter animated: Bool
     */
    public func scrollToTop(_ animated: Bool = true) {
        self.setContentOffset(CGPoint(x: 0, y: -self.contentInset.top), animated: animated)
    }
    
    /**
     scroll To Bottom
     - parameter animated: Bool
     */
    public func scrollToBottom(_ animated: Bool = true) {
        self.setContentOffset(CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height), animated: animated)
    }
}
