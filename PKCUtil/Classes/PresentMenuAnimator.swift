

import UIKit

public class PresentMenuAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    public var direction : Direction = .down
    public var snapshotNumber: Int = 0
    public var menuWidth: CGFloat = 0
    
    
    required public init(_ direction: Direction, snapshotNumber: Int, menuWidth: CGFloat) {
        super.init()
        
        self.direction = direction
        self.snapshotNumber = snapshotNumber
        self.menuWidth = menuWidth
    }
    
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    
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
