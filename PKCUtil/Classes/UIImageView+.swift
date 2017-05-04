//
//  CustomUIImageView.swift
//  Editor
//
//  Created by guanho on 2017. 1. 4..
//  Copyright © 2017년 guanho. All rights reserved.
//

import UIKit

public extension UIImageView{
    //aspectFit 실제 사이즈
    public func frameForImageInImageViewAspectFit() -> CGRect{
        if  let img = self.image {
            let imageRatio = img.size.width / img.size.height
            let viewRatio = self.frame.size.width / self.frame.size.height
            if(imageRatio < viewRatio){
                let scale = self.frame.size.height / img.size.height
                let width = scale * img.size.width
                let topLeftX = (self.frame.size.width - width) * 0.5
                return CGRect(x: topLeftX, y: 0, width: width, height: self.frame.size.height)
            }else{
                let scale = self.frame.size.width / img.size.width
                let height = scale * img.size.height
                let topLeftY = (self.frame.size.height - height) * 0.5
                return CGRect(x: 0, y: topLeftY, width: self.frame.size.width, height: height)
            }
        }
        
        return CGRect(x: 0, y: 0, width: 0, height: 0)
    }
}
