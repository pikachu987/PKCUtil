//
//  UIScrollView.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import UIKit

public extension UIScrollView {
    //scroll을 최상위로 올리기
    public func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
    //scroll을 최하위로 내리기
    public func scrollToBottom() {
        let desiredOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(desiredOffset, animated: true)
    }
}
