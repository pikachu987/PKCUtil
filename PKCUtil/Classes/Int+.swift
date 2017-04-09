//
//  Int+.swift
//  Pods
//
//  Created by guanho on 2017. 3. 31..
//
//

import Foundation


public extension Int {
    public var degreesToRadians: Double { return Double(self) * Double.pi / 180 }
    
    public func priceComma() -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        if let pointValue = numberFormatter.string(from: NSNumber(value: self)){
            return pointValue
        }else{
            return "0"
        }
    }
    
    public func setTimeDate() -> String{
        if self < 10{
            return "0\(self)"
        }else{
            return "\(self)"
        }
    }
}
