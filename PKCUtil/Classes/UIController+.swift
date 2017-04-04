//
//  UIController+.swift
//  Pods
//
//  Created by guanho on 2017. 4. 1..
//
//

import UIKit

extension UIViewController{
    func performWithHandler(segue: String, completion: @escaping ()->()){
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.performSegue(withIdentifier: segue, sender: nil)
        CATransaction.commit()
    }
}
extension UINavigationController {
    func popViewControllerWithHandler(completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: false)
        CATransaction.commit()
    }
    func pushViewController(viewController: UIViewController, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: false)
        CATransaction.commit()
    }
}
