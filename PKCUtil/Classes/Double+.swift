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
    public var degreesToRadians: DoubleConvertible {
        return Self(double * Double.pi / 180)
    }
    public var radiansToDegrees: DoubleConvertible {
        return Self(double * 180 / Double.pi)
    }
}


extension Double{
    func priceComma() -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        if let pointValue = numberFormatter.string(from: NSNumber(value: self)){
            return pointValue
        }else{
            return "0"
        }
    }
}
