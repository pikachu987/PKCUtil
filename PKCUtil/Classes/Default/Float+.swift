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

public extension Float{
    // MARK: property
    
    /// abs
    public var abs: Float{
        return self > 0 ? self : -self
    }
    
    /// priceComman
    public var priceComma: String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
    /// double
    public var dou: Double{
        return Double(self)
    }
    
    /// int
    public var int: Int{
        return Int(self)
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



public extension CGFloat{
    // MARK: property
    
    
    /// abs
    public var abs: CGFloat{
        return self > 0 ? self : -self
    }
    
    /// double
    public var dou: Double{
        return Double(self)
    }
    
    /// float
    public var float: Float{
        return Float(self)
    }
    
    /// int
    public var int: Int{
        return Int(self)
    }
    
    /// string
    public var string: String{
        return "\(self)"
    }
}

