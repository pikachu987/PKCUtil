//
//  UIView.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import UIKit

public extension UIView {
    //해당 뷰를 이미지로 만들기
    public func imageWithView() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    
    //nib파일을 가져와서 오토레이아웃까지 추가하기
    public func addSubview(_ nibName: String, owner: UIViewController) -> UIView{
        let view = Bundle.main.loadNibNamed(nibName, owner: owner, options: nil)?.first as! UIView
        view.addFullConstraints(self)
        return view
    }
    
    //오토레이아웃 추가하기
    public func addFullConstraints(_ superView: UIView, top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0){
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        let view_constraint_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(left)-[view]-\(right)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self])
        let view_constraint_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(top)-[view]-\(bottom)-|", options: NSLayoutFormatOptions.alignAllLeading, metrics: nil, views: ["view": self])
        superView.addConstraints(view_constraint_H)
        superView.addConstraints(view_constraint_V)
    }
    
    @discardableResult
    public func addRectConstraints(_ superView: UIView, top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) -> [NSLayoutConstraint]{
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        let topConst = NSLayoutConstraint(item: superView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: top)
        let bottomConst = NSLayoutConstraint(item: superView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: bottom)
        let leadingConst = NSLayoutConstraint(item: superView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: leading)
        let trailingConst = NSLayoutConstraint(item: superView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: trailing)
        superView.addConstraints([topConst, bottomConst, leadingConst, trailingConst])
        return [topConst, bottomConst, leadingConst, trailingConst]
    }
    
    @discardableResult
    public func horizontalLayout(left: CGFloat = 0, right: CGFloat = 0) -> [NSLayoutConstraint]{
        return NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(left)-[view]-\(right)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self])
    }
    
    @discardableResult
    public func verticalLayout(top: CGFloat = 0, bottom: CGFloat = 0) -> [NSLayoutConstraint]{
        return NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(top)-[view]-\(bottom)-|", options: NSLayoutFormatOptions.alignAllLeading, metrics: nil, views: ["view": self])
    }
    
    //테두리 설정
    public func setBorder(_ color: UIColor, width: CGFloat, radius: CGFloat){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
    }
    
    //패턴으로 테두리 설정
    public func addDashedBorder(_ color : UIColor, lineWidth : CGFloat!, dashPattern : [NSNumber], cornerRadius : CGFloat) {
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    
    //한면만 테두리 설정
    public func layer(_ rect: UIRectEdge = .bottom, borderWidth : CGFloat = 1, color : UIColor = UIColor.black, border : CALayer = CALayer()) -> CALayer{
        border.borderColor = color.cgColor
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        if rect == UIRectEdge.top{
            border.frame = CGRect(x: 0, y: 0, width:  self.frame.size.width, height: borderWidth)
        }else if rect == UIRectEdge.bottom{
            border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width:  self.frame.size.width, height: borderWidth)
        }else if rect == UIRectEdge.left{
            border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: self.frame.size.height)
        }else if rect == UIRectEdge.right{
            border.frame = CGRect(x: self.frame.size.width - borderWidth, y: 0, width: borderWidth, height: self.frame.size.height)
        }
        return border
    }
}


//@IBDesignable public extension UIView {
//    @IBInspectable var borderColor:UIColor? {
//        set {
//            layer.borderColor = newValue!.cgColor
//        }
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor:color)
//            }
//            else {
//                return nil
//            }
//        }
//    }
//    @IBInspectable var borderWidth:CGFloat {
//        set {
//            layer.borderWidth = newValue
//        }
//        get {
//            return layer.borderWidth
//        }
//    }
//    @IBInspectable var cornerRadius:CGFloat {
//        set {
//            layer.cornerRadius = newValue
//            clipsToBounds = newValue > 0
//        }
//        get {
//            return layer.cornerRadius
//        }
//    }
//}
