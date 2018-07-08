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

// PageViewControllerDelegate
public protocol PageViewControllerDelegate: class {
    /// pageViewController count
    func pageViewController(_ pageViewController: UIPageViewController, count: Int)
    /// pageViewController index
    func pageViewController(_ pageViewController: UIPageViewController, index: Int)
}

public extension PageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, count: Int){ }
    func pageViewController(_ pageViewController: UIPageViewController, index: Int){ }
}


// PageViewController
public class PageViewController: UIPageViewController{
    // MARK: var
    
    /// delegate
    weak public var pageViewDelegate: PageViewControllerDelegate?
    
    /// viewControllers
    public lazy var orderedViewControllers: [UIViewController] = [UIViewController]()
    
    /// isReload Infinite PageViewController
    public var isReload = false
    
    // MARK: initialize
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    // MARK: func
    
    /// Left Right Swipe
    public func setDataSource(){
        self.dataSource = self
    }
    
    /// init View
    public func initView(_ viewController: [UIViewController]){
        self.orderedViewControllers = viewController
        if let initialViewController = self.orderedViewControllers.first {
            scrollToViewController(initialViewController)
        }
        self.pageViewDelegate?.pageViewController(self, count: orderedViewControllers.count)
    }
    
    
    /// scroll
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
            scrollToViewController(nextViewController)
        }
    }
    
    /// scroll To Index
    public func scrollToViewController(_ index: Int, isNotify: Bool = true) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = index >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[index]
            scrollToViewController(nextViewController, direction: direction, isNotify: isNotify)
        }
    }
    
    /// New ViewController
    public static func newViewController(_ id: String, storyBoard: String) -> UIViewController {
        return UIStoryboard(name: storyBoard, bundle: nil).instantiateViewController(withIdentifier: "\(id)")
    }
    
    /// Scroll To ViewController
    private func scrollToViewController(_ viewController: UIViewController, direction: UIPageViewControllerNavigationDirection = .forward, isNotify: Bool = true) {
        setViewControllers([viewController],direction: direction,animated: true,completion: { (finished) -> Void in
            self.notifyDelegateOfNewIndex(isNotify)
        })
    }
    
    /// Notify NewIndex
    private func notifyDelegateOfNewIndex(_ isNotify: Bool = true) {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            if isNotify {
                self.pageViewDelegate?.pageViewController(self, index: index)
            }
        }
    }
    
}






extension PageViewController: UIPageViewControllerDelegate {
    // MARK: UIPageViewControllerDelegate
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.notifyDelegateOfNewIndex()
    }
}





extension PageViewController: UIPageViewControllerDataSource {
    // MARK: UIPageViewControllerDataSource
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        if !self.isReload{
            if previousIndex < 0{ return nil }
        }
        guard previousIndex >= 0 else { return orderedViewControllers.last }
        guard orderedViewControllers.count > previousIndex else { return nil }
        return orderedViewControllers[previousIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        if !self.isReload{
            if nextIndex >= orderedViewControllers.count{ return nil }
        }
        guard orderedViewControllers.count != nextIndex else { return orderedViewControllers.first }
        return orderedViewControllers[nextIndex]
    }
}
