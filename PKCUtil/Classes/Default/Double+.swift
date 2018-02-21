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

import Foundation
import UIKit

/**
 *
 * Double -> Double
 * Float -> Double
 * CGFloat -> Double
 * Protocol
 *
 */
public protocol DoubleConvertible {
    init(_ double: Double)
    var double: Double { get }
}

extension Double : DoubleConvertible { public var double: Double { return self         } }
extension Float  : DoubleConvertible { public var double: Double { return Double(self) } }
extension CGFloat: DoubleConvertible { public var double: Double { return Double(self) } }


public extension DoubleConvertible {
    /// Degress To Radians
    public var degreesToRadians: CGFloat {
        return Self(double * Double.pi / 180) as? CGFloat ?? 0
    }
    
    /// Radians To Degress
    public var radiansToDegrees: CGFloat {
        return Self(double * 180 / Double.pi) as? CGFloat ?? 0
    }
}




public extension Double{
    
    // MARK: property
    
    /// abs
    public var abs: Double{
        return self > 0 ? self : -self
    }
    
    /// priceComma
    public var priceComma: String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
    /// int
    public var int: Int{
        return Int(self)
    }
    /// float
    public var float: Float{
        return Float(self)
    }
    /// cgFloat
    public var cgFloat: CGFloat{
        return CGFloat(self)
    }
    /// string
    public var string: String{
        return String(self)
    }
}
