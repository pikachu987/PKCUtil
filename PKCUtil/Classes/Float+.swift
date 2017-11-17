//
//  Float+.swift
//  Pods
//
//  Created by pikachu987 on 2017. 8. 1..
//
//

import Foundation



public extension Float{
    
    public func abs() -> Float{
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
    
    public var dou: Double{
        get{
            return Double(self)
        }
    }
    public var int: Int{
        get{
            return Int(self)
        }
    }
    public var cgFloat: CGFloat{
        get{
            return CGFloat(self)
        }
    }
    public var string: String{
        get{
            return String(self)
        }
    }
}



public extension CGFloat{
    public func abs() -> CGFloat{
        return self > 0 ? self : -self
    }
    
    public var dou: Double{
        get{
            return Double(self)
        }
    }
    public var float: Float{
        get{
            return Float(self)
        }
    }
    public var int: Int{
        get{
            return Int(self)
        }
    }
    public var string: String{
        get{
            return "\(self)"
        }
    }
}

