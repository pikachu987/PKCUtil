//
//  UIScrollView.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import UIKit

public extension UIScrollView {
    public func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
    public func scrollToBottom() {
        let desiredOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(desiredOffset, animated: true)
    }
}
