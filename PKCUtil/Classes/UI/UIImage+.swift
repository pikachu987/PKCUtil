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

public extension UIImage {
    
    // MARK: property
    
    /// data
    public var data: Data{
        return UIImagePNGRepresentation(self) ?? Data()
    }
    
    /// pngData
    public var pngData: Data{
        return UIImagePNGRepresentation(self) ?? Data()
    }
    
    /// jpegData
    public var jpegData: Data{
        return UIImageJPEGRepresentation(self, 0.5) ?? Data()
    }
    
    
    
    // MARK: func
    
    /**
     fill color Image
     - parameter color: UIColor
     - parameter size: CGSize
     - returns: UIImage
     */
    public func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage{
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else{ return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
    
    
    
    
    /**
     rotate
     - parameter degrees: CGFloat
     - parameter flip: Bool
     - returns: UIImage?
     */
    public func imageRotatedByDegrees(_ degrees: CGFloat, flip: Bool) -> UIImage? {
        let degreesToRadians: (CGFloat) -> CGFloat = { return $0 / 180.0 * CGFloat(Double.pi) }
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        bitmap?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0);
        bitmap?.rotate(by: degreesToRadians(degrees));
        let yFlip = flip ? CGFloat(-1.0) : CGFloat(1.0)
        bitmap?.scaleBy(x: yFlip, y: -1.0)
        guard let cgImg = self.cgImage else{ return nil }
        bitmap?.draw(cgImg, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    
    /**
     resize
     - parameter size: CGSize
     - parameter scale: CGFloat
     - parameter hasAlpha: Bool
     - returns: UIImage?
     */
    public func resize(_ size: CGSize, scale: CGFloat = 1, hasAlpha: Bool = false) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(size, hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    
    
    
    /**
     percentage
     - parameter percentage: CGFloat
     - returns: UIImage?
     */
    public func rePercentage(_ percentage: CGFloat) -> UIImage {
        guard let data = UIImageJPEGRepresentation(self, percentage) else { return UIImage() }
        return UIImage(data: data) ?? UIImage()
    }
    
    
    
    /**
     percentage PNG
     - parameter percentage: CGFloat
     - returns: UIImage?
     */
    public func rePercentagePNG(_ percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
    
    /**
     resize + percentage
     - parameter size: CGFloat
     - parameter percent: CGFloat
     - parameter handler: ((UIImage) -> Void)
     */
    public func resized(size: CGFloat = 1000, percent: CGFloat = 0.15, handler: @escaping ((UIImage) -> Void)){
        var width: CGFloat = 0
        var height: CGFloat = 0
        if self.size.width > self.size.height{
            width = size
            height = width*self.size.height/self.size.width
        }else{
            height = size
            width = height*self.size.width/self.size.height
        }
        DispatchQueue.global().async {
            if let image = self.resize(CGSize(width: width, height: height))?.rePercentage(percent){
                DispatchQueue.main.async { handler(image) }
            }
        }
    }
    
    
    /**
     avarage color
     - parameter pos: CGPoint
     - returns: UIColor
     */
    public func pixelColor(_ pos: CGPoint) -> UIColor {
        guard let pixelData = self.cgImage?.dataProvider?.data else{ return .clear }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    
    
    
    /**
     change color
     - parameter color: UIColor
     - returns: UIImage?
     */
    public func rendering(_ color: UIColor) -> UIImage?{
        return self.colorized(color)?.withRenderingMode(.alwaysOriginal)
    }
    
    
    
    
    
    
    /**
     change color
     - parameter color: UIColor
     - returns: UIImage?
     */
    public func colorized(_ color : UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setBlendMode(CGBlendMode.normal)
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            if let cgImage = self.cgImage{
                context.draw(cgImage, in: rect)
                context.clip(to: rect, mask: cgImage)
            }
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        let colorizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorizedImage
    }
}
