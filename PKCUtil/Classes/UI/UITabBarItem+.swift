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

public extension UITabBarItem{
    
    // MARK: func
    
    /**
     setEntity
     - parameter title: String
     - parameter imageName: String
     */
    public func setEntity(_ title: String, imageName: String){
        self.image = UIImage(named: imageName)
        self.selectedImage = UIImage(named: imageName)
        self.imageInsets = UIEdgeInsets.zero
        self.title = title
    }
    
    
    /**
     setEntity
     - parameter title: String
     - parameter imageName: String
     - parameter color: UIColor
     */
    public func setEntity(_ title: String, imageName: String, color: UIColor){
        self.image = UIImage(named: imageName)?.rendering(color)
        self.selectedImage = UIImage(named: imageName)?.rendering(color)
        self.imageInsets = UIEdgeInsets.zero
        self.title = title
    }
    
    /**
     setEntity
     - parameter title: String
     - parameter imageName: String
     - parameter color: UIColor
     - parameter selectedColor: UIColor
     */
    public func setEntity(_ title: String, imageName: String, color: UIColor, selectedColor: UIColor){
        self.image = UIImage(named: imageName)?.rendering(color)
        self.selectedImage = UIImage(named: imageName)?.rendering(selectedColor)
        self.imageInsets = UIEdgeInsets.zero
        self.title = title
    }
    
    
    
    /**
     setEntity
     - parameter title: String
     - parameter image: String
     - parameter selectedColor: UIColor
     */
    public func setEntity(_ title: String, image: UIImage, selectedImage: UIImage){
        self.image = image
        self.selectedImage = selectedImage
        self.imageInsets = UIEdgeInsets.zero
        self.title = title
    }
}
