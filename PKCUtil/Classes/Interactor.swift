

import UIKit

public class Interactor: UIPercentDrivenInteractiveTransition {
    public var hasStarted = false
    public var shouldFinish = false
}

public enum Direction {
    case up
    case down
    case left
    case right
}


public class OriginHelper: Helper {
    public static let menuWidth:CGFloat = 1
    public static let percentThreshold:CGFloat = 0.4
    public static let snapshotNumber = 12340
    
    public static func calculateProgress(_ translationInView:CGPoint, viewBounds:CGRect, direction:Direction) -> CGFloat {
        let pointOnAxis:CGFloat
        let axisLength:CGFloat
        switch direction {
        case .up, .down:
            pointOnAxis = translationInView.y
            axisLength = viewBounds.height
        case .left, .right:
            pointOnAxis = translationInView.x
            axisLength = viewBounds.width
        }
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis:Float
        let positiveMovementOnAxisPercent:Float
        switch direction {
        case .right, .down: // positive
            positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
            return CGFloat(positiveMovementOnAxisPercent)
        case .up, .left: // negative
            positiveMovementOnAxis = fminf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fmaxf(positiveMovementOnAxis, -1.0)
            return CGFloat(-positiveMovementOnAxisPercent)
        }
    }
    
    public static func mapGestureStateToInteractor(_ gestureState:UIGestureRecognizerState, progress:CGFloat, interactor: Interactor?, triggerSegue: () -> ()){
        guard let interactor = interactor else { return }
        switch gestureState {
        case .began:
            interactor.hasStarted = true
            triggerSegue()
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish ? interactor.finish() : interactor.cancel()
        default:
            break
        }
    }
    
}



public class Helper{}
