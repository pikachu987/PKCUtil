//
//  Double+.swift
//  Pods
//
//  Created by guanho on 2017. 3. 31..
//
//

import Foundation

//degree <-> radian
public protocol DoubleConvertible {
    init(_ double: Double)
    var double: Double { get }
}
//degree <-> radian
extension Double : DoubleConvertible { public var double: Double { return self         } }
extension Float  : DoubleConvertible { public var double: Double { return Double(self) } }
extension CGFloat: DoubleConvertible { public var double: Double { return Double(self) } }

//degree <-> radian
public extension DoubleConvertible {
    public var degreesToRadians: CGFloat {
        if let value = Self(double * Double.pi / 180) as? CGFloat{
            return value
        }else{
            return 0
        }
    }
    public var radiansToDegrees: CGFloat {
        if let value = Self(double * 180 / Double.pi) as? CGFloat{
            return value
        }else{
            return 0
        }
    }
}


public extension Double{
    //abs
    public func abs() -> Double{
        return self > 0 ? self : -self
    }
    
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
