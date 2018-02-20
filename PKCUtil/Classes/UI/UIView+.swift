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

public extension UIView {
    
    
    
    // MARK: initialize
    
    
    public convenience init(color: UIColor) {
        self.init()
        self.backgroundColor = color
    }
    
    
    // MARK: property
    
    /// view To UIImage
    public var imageWithView: UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    
    
    // MARK: func
    
    
    
    /**
     addSubviewEdgeConstraint
     - parameter view: UIView
     - parameter leading: CGFloat
     - parameter top: CGFloat
     - parameter trailing: CGFloat
     - parameter bottom: CGFloat
     - returns: [NSLayoutConstraint]
     */
    @discardableResult
    public func addSubviewEdgeConstraint(
        _ view: UIView,
        leading: CGFloat = 0,
        top: CGFloat = 0,
        trailing: CGFloat = 0,
        bottom: CGFloat = 0) -> [NSLayoutConstraint]{
        
        self.addSubview(view)
        return self.addEdgesConstraints(view, leading: leading, top: top, trailing: trailing, bottom: bottom)
    }
    
    /**
     addEdgesConstraints
     - parameter view: UIView
     - parameter leading: CGFloat
     - parameter top: CGFloat
     - parameter trailing: CGFloat
     - parameter bottom: CGFloat
     - returns: [NSLayoutConstraint]
     */
    @discardableResult
    public func addEdgesConstraints(
        _ view: UIView,
        leading: CGFloat = 0,
        top: CGFloat = 0,
        trailing: CGFloat = 0,
        bottom: CGFloat = 0) -> [NSLayoutConstraint]{
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(
            item: self,
            attribute: .leading,
            relatedBy: .equal,
            toItem: view,
            attribute: .leading,
            multiplier: 1,
            constant: leading
        )
        let trailingConstraint = NSLayoutConstraint(
            item: self,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view,
            attribute: .trailing,
            multiplier: 1,
            constant: trailing
        )
        let topConstraint = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: top
        )
        let bottomConstraint = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: bottom
        )
        let constraints = [ leadingConstraint, trailingConstraint, topConstraint, bottomConstraint ]
        self.addConstraints(constraints)
        
        return constraints
    }
    
    /**
     horizontalLayout
     - parameter left: CGFloat
     - parameter right: CGFloat
     - returns: [NSLayoutConstraint]
     */
    @discardableResult
    public func horizontalLayout(left: CGFloat = 0, right: CGFloat = 0) -> [NSLayoutConstraint]{
        return NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(left)-[view]-\(right)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self])
    }
    
    /**
     verticalLayout
     - parameter top: CGFloat
     - parameter bottom: CGFloat
     - returns: [NSLayoutConstraint]
     */
    @discardableResult
    public func verticalLayout(top: CGFloat = 0, bottom: CGFloat = 0) -> [NSLayoutConstraint]{
        return NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(top)-[view]-\(bottom)-|", options: NSLayoutFormatOptions.alignAllLeading, metrics: nil, views: ["view": self])
    }
    
    
    
    
    /**
     pattern border
     - parameter color: UIColor
     - parameter width: CGFloat
     - parameter cornerRadius: CGFloat
     - parameter dashPattern: [NSNumber]
     - returns: CAShapeLayer
     */
    @discardableResult
    public func addDashedBorder(_ color : UIColor, borderwidth : CGFloat = 1, cornerRadius : CGFloat, dashPattern : [NSNumber]) -> CAShapeLayer{
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = borderwidth
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath
        self.layer.addSublayer(shapeLayer)
        return shapeLayer
    }
    
    
    
    
    
    
}
