//
//  UIImage.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import UIKit


//확장자
public enum ExtType{
    case jpeg, png
}



public extension UIImage {
    //해당영역 사이즈만큼 컬러를 채우고 Image로 뽑기
    public func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage{
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    
    
    //image를 회전시키기
    public func imageRotatedByDegrees(_ degrees: CGFloat, flip: Bool) -> UIImage? {
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(Double.pi)
        }
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
        guard let cgImg = self.cgImage else{
            return nil
        }
        bitmap?.draw(cgImg, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    //이미지 리사이즈 시키기
    public func resize(_ size: CGSize) -> UIImage?{
        let hasAlpha = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    //이미지 화질 변경 시키기
    public func rePercentage(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    //이미지 리사이즈 하기(width기반)
    @available(iOS, message: "resize")
    public func resizedPercentage(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
    //이미지를 크기만큼 줄이기 -> resize
    @available(iOS, message: "resize")
    public func crop(_ to:CGSize) -> UIImage? {
        guard let cgimage = self.cgImage else { return self }
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = to.width / to.height
        var cropWidth: CGFloat = to.width
        var cropHeight: CGFloat = to.height
        if to.width > to.height { //Landscape
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        } else if to.width < to.height { //Portrait
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        } else { //Square
            if contextSize.width >= contextSize.height {
                cropHeight = contextSize.height
                cropWidth = contextSize.height * cropAspect
                posX = (contextSize.width - cropWidth) / 2
            }else{ //Square on portrait
                cropWidth = contextSize.width
                cropHeight = contextSize.width / cropAspect
                posY = (contextSize.height - cropHeight) / 2
            }
        }
        let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        UIGraphicsBeginImageContextWithOptions(to, true, self.scale)
        cropped.draw(in: CGRect(x: 0, y: 0, width: to.width, height: to.height))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized
    }
    
    
    //이미지 평균 컬러
    public func getPixelColor(pos: CGPoint) -> UIColor {
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    
    
    
    //이미지를 데이터로 바꾸기
    public func returnImageData(_ ext : ExtType) -> Data{
        var data : Data = Data()
        switch ext {
        case .jpeg:
            if let tmpData = UIImageJPEGRepresentation(self, 0.5){
                data = tmpData
            }
            break
        case .png:
            if let tmpData = UIImagePNGRepresentation(self){
                data = tmpData
            }
            break
        }
        return data
    }
    
    
    //이미지 리사이즈+화질 변경
    public func resizedImage(size: CGFloat = 1000, percent: CGFloat = 0.15, handler: @escaping ((UIImage) -> Void)){
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
            if let image = self.resize(CGSize(width: width, height: height))?.rePercentage(withPercentage: percent){
                DispatchQueue.main.async {
                    handler(image)
                }
            }
        }
    }
    
    
    //이미지 컬러 바꿈
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
