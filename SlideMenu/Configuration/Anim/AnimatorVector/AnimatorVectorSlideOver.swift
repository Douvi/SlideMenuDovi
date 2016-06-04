//
//  AnimatorVectorSlideOver.swift
//  carrefour
//
//  Created by Edouard Roussillon on 6/3/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public protocol AnimatorVectorSlideOver: AnimatorVector {}

extension AnimatorVectorSlideOver {
    
    public func resetAnimationLeftSide() {
        self.menuTools.menuViews.leftContainerView.frame.origin = CGPointMake(-SliderMenuOptions.leftViewWidth, 0)
    }
    
    public func resetAnimationRightSide() {
        self.menuTools.menuViews.rightContainerView.frame.origin = CGPointMake(self.rootView.bounds.width, 0)
    }
    
    public func openLeftWithVelocity(velocity: CGFloat) {
        let xOrigin: CGFloat = self.menuViews.leftContainerView.frame.origin.x
        let finalXOrigin: CGFloat = 0.0
        
        var frame = self.menuViews.leftContainerView.frame
        frame.origin.x = finalXOrigin
        
        var duration: NSTimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        self.gesture.addLeftTapGestures()
        self.animationType.addShadowToView(self.menuViews.leftContainerView)
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            self.menuViews.leftContainerView.frame = frame
            self.menuViews.opacityView.frame = frame
            self.menuViews.opacityView.layer.opacity = Float(SliderMenuOptions.contentViewOpacity)
        }) {(Bool) -> Void in
            self.menuTools.disableContentInteraction()
            self.menuTools.menuViewControllers.leftViewController?.endAppearanceTransition()
        }
    }
    
    public func closeLeftWithVelocity(velocity: CGFloat) {
        
        let xOrigin: CGFloat = self.menuViews.leftContainerView.frame.origin.x
        let finalXOrigin: CGFloat = -SliderMenuOptions.leftViewWidth
        
        var frame: CGRect = self.menuViews.leftContainerView.frame
        frame.origin.x = finalXOrigin
        
        var duration: NSTimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != -SliderMenuOptions.leftViewWidth {
            duration = Double(fabs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        self.gesture.removeLeftTapGestures()
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            self.menuViews.leftContainerView.frame = frame
            self.menuViews.opacityView.frame = frame
            self.menuViews.opacityView.layer.opacity = 0.0
        }) {(Bool) -> Void in
            self.animationType.removeShadow(self.menuViews.leftContainerView)
            self.menuTools.enableContentInteraction()
            self.menuTools.menuViewControllers.leftViewController?.endAppearanceTransition()
        }
    }
    
    public func openRightWithVelocity(velocity: CGFloat) {
        let lastPosition = self.rootView.frame.width - SliderMenuOptions.rightViewWidth
        var frame = self.menuViews.rightContainerView.frame
        frame.origin.x = lastPosition
        
        let from = fabs(self.menuViews.rightContainerView.frame.origin.x)
        let to = fabs(frame.origin.x)
        
        var duration: NSTimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != lastPosition {
            duration = Double(fabs(to - from) / fabs(velocity))
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        self.animationType.addShadowToView(self.menuViews.rightContainerView)
        self.gesture.addRightTapGestures()
        
        UIView.animateWithDuration(duration, delay: 0.0, options: .CurveEaseInOut, animations: {() -> Void in
            self.menuViews.rightContainerView.frame = frame
            self.menuViews.opacityView.frame = frame
            self.menuViews.opacityView.layer.opacity = Float(SliderMenuOptions.contentViewOpacity)
        }) {(Bool) -> Void in
            self.menuTools.disableContentInteraction()
            self.menuViewControllers.rightViewController?.endAppearanceTransition()
        }
    }
    
    public func closeRightWithVelocity(velocity: CGFloat) {
        let xOrigin: CGFloat = self.menuViews.rightContainerView.frame.origin.x
        
        var frame = self.menuViews.rightContainerView.frame
        frame.origin.x = self.rootView.bounds.width
        
        var duration: NSTimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != self.rootView.bounds.width {
            duration = Double(fabs(CGRectGetWidth(self.rootView.bounds) - xOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        self.gesture.removeRightTapGestures()
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            self.menuViews.rightContainerView.frame = frame
            self.menuViews.opacityView.frame = frame
            self.menuViews.opacityView.layer.opacity = 0.0
        }) {(Bool) -> Void in
            self.menuTools.removeShadow(self.menuViews.rightContainerView)
            self.menuTools.enableContentInteraction()
            self.menuViewControllers.rightViewController?.endAppearanceTransition()
        }
    }
    
}