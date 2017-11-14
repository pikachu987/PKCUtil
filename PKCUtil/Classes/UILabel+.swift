//
//  UILabel+.swift
//  Pods
//
//  Created by guanho on 2017. 3. 31..
//
//

import UIKit


public extension UILabel{
    public convenience init(text: String, font: UIFont = UIFont.systemFont(ofSize: 17), textColor: UIColor = .black){
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }
    
    
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
