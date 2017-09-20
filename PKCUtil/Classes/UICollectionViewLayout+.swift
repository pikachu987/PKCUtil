//
//  UICollectionViewLayout+.swift
//  PKCUtil
//
//  Created by docfriends on 2017. 9. 20..
//

import UIKit

//콜렉션뷰 레이아웃
public extension UICollectionViewLayout{
    
    //width, height를 받는 레이아웃
    public static func horizontalLayout(width: CGFloat, height: CGFloat) -> UICollectionViewLayout{
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flow.itemSize = CGSize(width: width, height: height)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        return flow
    }
    
    
    
    public func size() -> CGSize{
        if let flow = self as? UICollectionViewFlowLayout{
            return flow.itemSize
        }else{
            return .zero
        }
    }
}

