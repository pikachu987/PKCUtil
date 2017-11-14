//
//  PKCPageViewController.swift
//  Pods
//
//  Created by guanho on 2017. 3. 31..
//
//

import UIKit

@objc public protocol PKCPageViewControllerDelegate: class {
    @objc optional func pkcPageViewController(_ pageViewController: UIPageViewController, didUpdatePageCount count: Int)
    @objc optional func pkcPageViewController(_ pageViewController: UIPageViewController, didUpdatePageIndex index: Int)
}


//페이지뷰 커스텀하기
public class PKCPageViewController: UIPageViewController{
    weak public var pageViewDelegate: PKCPageViewControllerDelegate?
    public lazy var orderedViewControllers: [UIViewController] = [UIViewController]()
    public var isReload = false
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    //좌우 스와이퍼
    public func setDataSource(){
        self.dataSource = self
    }
    
    public func initView(_ vc: [UIViewController]){
        self.orderedViewControllers = vc
        if let initialViewController = self.orderedViewControllers.first {
            scrollToViewController(initialViewController)
        }
        self.pageViewDelegate?.pkcPageViewController?(self, didUpdatePageCount: orderedViewControllers.count)
    }
    
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
            scrollToViewController(nextViewController)
        }
    }
    
    public func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(nextViewController, direction: direction)
        }
    }
    
    public static func newViewController(_ id: String, storyBoard: String) -> UIViewController {
        return UIStoryboard(name: storyBoard, bundle: nil).instantiateViewController(withIdentifier: "\(id)")
    }
    
    fileprivate func scrollToViewController(_ viewController: UIViewController, direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController],direction: direction,animated: true,completion: { (finished) -> Void in
            self.notifyDelegateOfNewIndex()
        })
    }
    
    fileprivate func notifyDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            self.pageViewDelegate?.pkcPageViewController?(self, didUpdatePageIndex: index)
        }
    }
    
}






extension PKCPageViewController: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        notifyDelegateOfNewIndex()
    }
}





extension PKCPageViewController: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        if !self.isReload{
            if previousIndex < 0{
                return nil
            }
        }
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        if !self.isReload{
            if nextIndex >= orderedViewControllers.count{
                return nil
            }
        }
        guard orderedViewControllers.count != nextIndex else {
            return orderedViewControllers.first
        }
        return orderedViewControllers[nextIndex]
    }
}
