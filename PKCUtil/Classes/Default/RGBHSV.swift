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

import UIKit

// RGB
public struct RGB {
    // MARK: property
    
    /// R
    public let r: CGFloat // [0,1]
    /// G
    public let g: CGFloat // [0,1]
    /// B
    public let b: CGFloat // [0,1]
    
    
    
    /// HSV
    public var hsv: HSV {
        return RGB.hsv(self)
    }
    
    
    
    
    
    // MARK: func
    
    
    /**
     RGB to HSV
     - parameter r: CGFloat
     - parameter g: CGFloat
     - parameter b: CGFloat
     - returns: HSV
     */
    public static func hsv(r: CGFloat, g: CGFloat, b: CGFloat) -> HSV {
        let min = r < g ? (r < b ? r : b) : (g < b ? g : b)
        let max = r > g ? (r > b ? r : b) : (g > b ? g : b)
        
        let v = max
        let delta = max - min
        
        guard delta > 0.00001 else { return HSV(h: 0, s: 0, v: max) }
        guard max > 0 else { return HSV(h: -1, s: 0, v: v) }
        let s = delta / max
        
        let hue: (CGFloat, CGFloat) -> CGFloat = { max, delta -> CGFloat in
            if r == max { return (g-b)/delta } // between yellow & magenta
            else if g == max { return 2 + (b-r)/delta } // between cyan & yellow
            else { return 4 + (r-g)/delta } // between magenta & cyan
        }
        let h = hue(max, delta) * 60 // degrees
        return HSV(h: (h < 0 ? h+360 : h) , s: s, v: v)
    }
    
    /**
     RGB to HSV
     - parameter rgb: RGB
     - returns: HSV
     */
    public static func hsv(_ rgb: RGB) -> HSV {
        return hsv(r: rgb.r, g: rgb.g, b: rgb.b)
    }
}


// RGBA
public struct RGBA {
    // MARK: property
    
    /// alpha
    let a: CGFloat
    
    /// rgb
    let rgb: RGB
    
    // MARK: initialize
    public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.a = a
        self.rgb = RGB(r: r, g: g, b: b)
    }
}

// HSV
public struct HSV {
    // MARK: property
    
    /// h
    public let h: CGFloat
    /// s
    public let s: CGFloat
    /// v
    public let v: CGFloat
    
    /// RGB
    public var rgb: RGB {
        return HSV.rgb(self)
    }
    
    
    /// point
    public var point: CGPoint {
        return CGPoint(x: CGFloat(h/360), y: CGFloat(v))
    }
    
    
    
    
    
    
    // MARK: func
    
    
    /**
     HSV to RGB
     - parameter h: CGFloat
     - parameter s: CGFloat
     - parameter v: CGFloat
     - returns: RGB
     */
    public static func rgb(_ h: CGFloat, s: CGFloat, v: CGFloat) -> RGB {
        if s == 0 { return RGB(r: v, g: v, b: v) }
        
        let angle = (h >= 360 ? 0 : h)
        let sector = angle / 60
        let i = floor(sector)
        let f = sector - i
        
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
    
    
    /**
     HSV to RGB
     - parameter hsv: HSV
     - returns: RGB
     */
    public static func rgb(_ hsv: HSV) -> RGB {
        return rgb(hsv.h, s: hsv.s, v: hsv.v)
    }
    
    
    
    
}
