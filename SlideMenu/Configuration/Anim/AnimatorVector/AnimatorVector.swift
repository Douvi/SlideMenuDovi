//
//  AnimatorVector.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/31/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

/**
 *  It will be call to close or open menu
 */
public protocol AnimatorVector: GlobalVariables {
    func resetAnimationLeftSide()
    func resetAnimationRightSide()
    func transitionToSize(transitionCoordinator: UIViewControllerTransitionCoordinator)

    func openLeftWithVelocity(velocity: CGFloat)
    func closeLeftWithVelocity(velocity: CGFloat)

    func openRightWithVelocity(velocity: CGFloat)
    func closeRightWithVelocity(velocity: CGFloat)
}

extension AnimatorVector {

    public func resetAnimationLeftSide() {
        self.menuTools.menuViews.mainContainerView.frame.origin = CGPointMake(0, 0)
    }

    public func resetAnimationRightSide() {
         self.menuTools.menuViews.mainContainerView.frame.origin = CGPointMake(0, 0)
    }

    public func transitionToSize(transitionCoordinator: UIViewControllerTransitionCoordinator) {
        self.menuViews.leftContainerView.hidden = true
        self.menuViews.rightContainerView.hidden = true

        transitionCoordinator.animateAlongsideTransition(nil, completion: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in

            self.animationType.resetAnimationLeftSide()
            self.animationType.resetAnimationRightSide()

            self.menuViews.leftContainerView.hidden = false
            self.menuViews.rightContainerView.hidden = false
        })
    }

    public func openLeftWithVelocity(velocity: CGFloat) {
        let xOrigin: CGFloat = self.menuViews.mainContainerView.frame.origin.x
        let finalXOrigin: CGFloat = SliderMenuOptions.leftViewWidth

        var frame = self.menuViews.mainContainerView.frame
        frame.origin.x = finalXOrigin

        var duration: NSTimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != finalXOrigin {
            duration = Double(fabs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }

        self.gesture.addLeftTapGestures()
        self.animationType.addShadowToView(self.menuViews.mainContainerView)

        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            self.menuViews.mainContainerView.frame = frame
            self.menuViews.opacityView.frame = frame
            self.menuViews.opacityView.layer.opacity = Float(SliderMenuOptions.contentViewOpacity)
        }) {(Bool) -> Void in
            self.menuTools.disableContentInteraction()
            self.menuTools.menuViewControllers.leftViewController?.endAppearanceTransition()
        }
    }

    public func closeLeftWithVelocity(velocity: CGFloat) {

        let xOrigin: CGFloat = self.menuViews.mainContainerView.frame.origin.x
        let finalXOrigin: CGFloat = 0.0

        var frame: CGRect = self.menuViews.mainContainerView.frame
        frame.origin.x = finalXOrigin

        var duration: NSTimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }

        self.gesture.removeLeftTapGestures()

        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            self.menuViews.mainContainerView.frame = frame
            self.menuViews.opacityView.frame = frame
            self.menuViews.opacityView.layer.opacity = 0.0
        }) {(Bool) -> Void in
            self.animationType.removeShadow(self.menuViews.mainContainerView)
            self.menuTools.enableContentInteraction()
            self.menuTools.menuViewControllers.leftViewController?.endAppearanceTransition()
        }
    }

    public func openRightWithVelocity(velocity: CGFloat) {

        var frame = self.menuViews.mainContainerView.frame
        frame.origin.x = -SliderMenuOptions.rightViewWidth

        let from = fabs(self.menuViews.mainContainerView.frame.origin.x)
        let to = fabs(frame.origin.x)

        var duration: NSTimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != -SliderMenuOptions.rightViewWidth {
            duration = Double(fabs(to - from) / fabs(velocity))
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }

        self.animationType.addShadowToView(self.menuViews.mainContainerView)
        self.gesture.addRightTapGestures()

        UIView.animateWithDuration(duration, delay: 0.0, options: .CurveEaseInOut, animations: {() -> Void in
            self.menuViews.mainContainerView.frame = frame
            self.menuViews.opacityView.frame = frame
            self.menuViews.opacityView.layer.opacity = Float(SliderMenuOptions.contentViewOpacity)
        }) {(Bool) -> Void in
            self.menuTools.disableContentInteraction()
            self.menuViewControllers.rightViewController?.endAppearanceTransition()
        }
    }

    public func closeRightWithVelocity(velocity: CGFloat) {
        let xOrigin: CGFloat = self.menuViews.mainContainerView.frame.origin.x

        var frame = self.menuViews.mainContainerView.frame
        frame.origin.x = 0.0

        var duration: NSTimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(CGRectGetWidth(self.rootView.bounds) - xOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }

        self.gesture.removeRightTapGestures()

        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            self.menuViews.mainContainerView.frame = frame
            self.menuViews.opacityView.frame = frame
            self.menuViews.opacityView.layer.opacity = 0.0
        }) {(Bool) -> Void in
            self.menuTools.removeShadow(self.menuViews.rightContainerView)
            self.menuTools.enableContentInteraction()
            self.menuViewControllers.rightViewController?.endAppearanceTransition()
        }
    }
}
