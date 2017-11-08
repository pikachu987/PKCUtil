//
//  RGBHSV.swift
//  PKCUtil
//
//  Created by docfriends on 2017. 11. 8..
//

import UIKit

public struct RGB {
    // Percent
    public let r: CGFloat // [0,1]
    public let g: CGFloat // [0,1]
    public let b: CGFloat // [0,1]
    
    public static func hsv(r: CGFloat, g: CGFloat, b: CGFloat) -> HSV {
        let min = r < g ? (r < b ? r : b) : (g < b ? g : b)
        let max = r > g ? (r > b ? r : b) : (g > b ? g : b)
        
        let v = max
        let delta = max - min
        
        guard delta > 0.00001 else { return HSV(h: 0, s: 0, v: max) }
        guard max > 0 else { return HSV(h: -1, s: 0, v: v) } // Undefined, achromatic grey
        let s = delta / max
        
        let hue: (CGFloat, CGFloat) -> CGFloat = { max, delta -> CGFloat in
            if r == max { return (g-b)/delta } // between yellow & magenta
            else if g == max { return 2 + (b-r)/delta } // between cyan & yellow
            else { return 4 + (r-g)/delta } // between magenta & cyan
        }
        
        let h = hue(max, delta) * 60 // In degrees
        
        return HSV(h: (h < 0 ? h+360 : h) , s: s, v: v)
    }
    
    public static func hsv(_ rgb: RGB) -> HSV {
        return hsv(r: rgb.r, g: rgb.g, b: rgb.b)
    }
    
    public var hsv: HSV {
        return RGB.hsv(self)
    }
}

public struct RGBA {
    let a: CGFloat
    let rgb: RGB
    
    public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.a = a
        self.rgb = RGB(r: r, g: g, b: b)
    }
}

public struct HSV {
    public let h: CGFloat // Angle in degrees [0,360] or -1 as Undefined
    public let s: CGFloat // Percent [0,1]
    public let v: CGFloat // Percent [0,1]
    
    public static func rgb(_ h: CGFloat, s: CGFloat, v: CGFloat) -> RGB {
        if s == 0 { return RGB(r: v, g: v, b: v) } // Achromatic grey
        
        let angle = (h >= 360 ? 0 : h)
        let sector = angle / 60 // Sector
        let i = floor(sector)
        let f = sector - i // Factorial part of h
        
        let p = v * (1 - s)
        let q = v * (1 - (s * f))
        let t = v * (1 - (s * (1 - f)))
        
        switch(i) {
        case 0:
            return RGB(r: v, g: t, b: p)
        case 1:
            return RGB(r: q, g: v, b: p)
        case 2:
            return RGB(r: p, g: v, b: t)
        case 3:
            return RGB(r: p, g: q, b: v)
        case 4:
            return RGB(r: t, g: p, b: v)
        default:
            return RGB(r: v, g: p, b: q)
        }
    }
    
    public static func rgb(_ hsv: HSV) -> RGB {
        return rgb(hsv.h, s: hsv.s, v: hsv.v)
    }
    
    public var rgb: RGB {
        return HSV.rgb(self)
    }
    
    /// Returns a normalized point with x=h and y=v
    public var point: CGPoint {
        return CGPoint(x: CGFloat(h/360), y: CGFloat(v))
    }
}
