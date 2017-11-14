//
//  UIController+.swift
//  Pods
//
//  Created by guanho on 2017. 4. 1..
//
//

import UIKit


public extension UIViewController{
    
    
    //segue이동후 해당 핸들러 실행
    public func performWithHandler(_ segue: String, completion: @escaping ()->()){
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.performSegue(withIdentifier: segue, sender: nil)
        CATransaction.commit()
    }
}



public extension UINavigationController {
    //pop이동후 해당 핸들러 실행
    public func popViewControllerWithHandler(_ animated: Bool, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }
    //push이동후 해당 핸들러 실행
    public func pushViewController(_ animated: Bool, viewController: UIViewController, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
