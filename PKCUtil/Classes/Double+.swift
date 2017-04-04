//
//  Double+.swift
//  Pods
//
//  Created by guanho on 2017. 3. 31..
//
//

import Foundation

public protocol DoubleConvertible {
    init(_ double: Double)
    var double: Double { get }
}
extension Double : DoubleConvertible { public var double: Double { return self         } }
extension Float  : DoubleConvertible { public var double: Double { return Double(self) } }
extension CGFloat: DoubleConvertible { public var double: Double { return Double(self) } }

public extension DoubleConvertible {
    public var degreesToRadians: DoubleConvertible {
        return Self(double * Double.pi / 180)
    }
    public var radiansToDegrees: DoubleConvertible {
        return Self(double * 180 / Double.pi)
    }
}
