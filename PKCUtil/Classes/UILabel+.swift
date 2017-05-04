//
//  UILabel+.swift
//  Pods
//
//  Created by guanho on 2017. 3. 31..
//
//

import UIKit


public extension UILabel{
    
    //라벨 높이 구하기
    public func requiredHeight(_ width: CGFloat) -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byClipping
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.height
    }
}
