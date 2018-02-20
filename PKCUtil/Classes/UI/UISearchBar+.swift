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

public extension UISearchBar{
    // MARK: property
    
    /// textField
    public var textField: UITextField{
        guard let textField = self.value(forKey: "_searchField") as? UITextField else {
            return UITextField()
        }
        return textField
    }
    
    // MARK: func
    
    /// header
    public static func headerViewSearchBar(_ placeHolder: String, tintColor: UIColor = UIColor(red: 76/255, green: 109/255, blue: 234/255, alpha: 1)) -> UISearchBar{
        let searchBar = UISearchBar(frame: CGRect(x: 50, y: 26, width: UIScreen.main.bounds.width-66, height: 28))
        searchBar.tintColor = tintColor
        searchBar.placeholder = placeHolder
        searchBar.enablesReturnKeyAutomatically = false
        return searchBar
    }
}
