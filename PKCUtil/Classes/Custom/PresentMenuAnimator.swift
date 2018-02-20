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


// PresentMenuAnimator
public class PresentMenuAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: var
    
    /// direction
    public var direction : Direction = .down
    
    /// number
    public var snapshotNumber: Int = 0
    
    /// width
    public var menuWidth: CGFloat = 0
    
    // MARK: initialize
    required public init(_ direction: Direction, snapshotNumber: Int, menuWidth: CGFloat) {
        super.init()
        
        self.direction = direction
        self.snapshotNumber = snapshotNumber
        self.menuWidth = menuWidth
    }
    
    // MARK: func
    
    /// duration
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    /// animate
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        
        guard let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false) else{
            return
        }
        snapshot.tag = self.snapshotNumber
        snapshot.isUserInteractionEnabled = false
        snapshot.layer.shadowOpacity = 0
        containerView.insertSubview(snapshot, aboveSubview: toVC.view)
        fromVC.view.isHidden = true
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                if self.direction == .right{
                    snapshot.center.x += UIScreen.main.bounds.width * self.menuWidth
                }else if self.direction == .left{
                    snapshot.center.x -= UIScreen.main.bounds.width * self.menuWidth
                }else if self.direction == .up{
                    snapshot.center.y += UIScreen.main.bounds.height * self.menuWidth
                }else if self.direction == .down{
                    snapshot.center.y -= UIScreen.main.bounds.height * self.menuWidth
                }
            },
            completion: { _ in
                fromVC.view.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
