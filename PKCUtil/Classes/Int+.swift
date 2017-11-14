//
//  Int+.swift
//  Pods
//
//  Created by guanho on 2017. 3. 31..
//
//

import Foundation


public extension Int {
    //abs
    public func abs() -> Int{
        return self > 0 ? self : -self
    }
    
    
    //degree <-> radian
    public var degreesToRadians: Double { return Double(self) * Double.pi / 180 }
    
    
    
    //숫자 포맷 지정 1,000,000
    public func priceComma() -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        if let pointValue = numberFormatter.string(from: NSNumber(value: self)){
            return pointValue
        }else{
            return "0"
        }
    }
    
    
}
