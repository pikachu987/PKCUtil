//
//  UIScrollView.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import UIKit

public extension UIScrollView {
    var deltaOffsetX: CGFloat{
        get{
            let currentOffset = self.contentOffset.y
            let maximumOffset = self.contentSize.height - self.frame.size.height
            let deltaOffset = maximumOffset - currentOffset
            return deltaOffset
        }
    }
    var deltaOffsetY: CGFloat{
        get{
            let currentOffset = self.contentOffset.x
            let maximumOffset = self.contentSize.width - self.frame.size.width
            let deltaOffset = maximumOffset - currentOffset
            return deltaOffset
        }
    }
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
