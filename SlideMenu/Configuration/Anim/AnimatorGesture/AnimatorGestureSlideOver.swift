//
//  AnimatorGestureSlideOver.swift
//  carrefour
//
//  Created by Edouard Roussillon on 6/3/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public protocol AnimatorGestureSlideOver: AnimatorGesture {}

extension AnimatorGestureSlideOver {
    
    //
    // MARK: Gesture Left
    //
    
    public func beganLeftTranslationGesture() {
        self.animationType.addShadowToView(self.menuViews.leftContainerView)
        self.menuViews.rightContainerView.frame.origin.x = self.rootView.frame.width
        self.menuViews.mainContainerView.frame.origin.x = 0
        self.menuViews.opacityView.frame.origin.x = 0
        LeftPanState.frameAtStartOfPan = self.menuViews.leftContainerView.frame
    }
    
    public func changedLeftTranslationGesture(frameTranslation: CGRect) {
        self.menuViews.leftContainerView.frame = frameTranslation
        self.menuTools.applyLeftOpacity()
    }
    
    public func endLeftTranslationGesture(velocity: CGPoint) -> PanInfo {
        var panInfo: PanInfo = PanInfo(action: .Close, shouldBounce: false, velocity: 0.0)
        
        let thresholdVelocity: CGFloat = 1000.0
        var pointOfNoReturn: CGFloat!
        let leftOrigin: CGFloat = self.menuViews.leftContainerView.frame.origin.x
        
        if velocity.x >= 0.0 {
            pointOfNoReturn = -SliderMenuOptions.leftViewWidth + SliderMenuOptions.pointOfNoReturnWidth
        } else {
            pointOfNoReturn = -SliderMenuOptions.pointOfNoReturnWidth
        }
        
        panInfo.action = leftOrigin <= pointOfNoReturn ? .Close : .Open
        
        if velocity.x >= thresholdVelocity {
            panInfo.action = .Open
            panInfo.velocity = velocity.x
        } else if velocity.x <= (-1.0 * thresholdVelocity) {
            panInfo.action = .Close
            panInfo.velocity = velocity.x
        }
        
        return panInfo
    }
    
    //
    // MARK: Gesture Right
    //
    
    public func beganRightTranslationGesture() {
        self.animationType.addShadowToView(self.menuViews.rightContainerView)
        self.menuViews.leftContainerView.frame.origin.x = -SliderMenuOptions.leftViewWidth
        self.menuViews.mainContainerView.frame.origin.x = 0
        self.menuViews.opacityView.frame.origin.x = 0
        RightPanState.frameAtStartOfPan = self.menuViews.rightContainerView.frame
    }
    
    public func changedRightTranslationGesture(frameTranslation: CGRect) {
        self.menuViews.rightContainerView.frame = frameTranslation
        self.menuTools.applyRightOpacity()
    }
    
    public func endRightTranslationGesture(velocity: CGPoint) -> PanInfo {
        var panInfo: PanInfo = PanInfo(action: .Close, shouldBounce: false, velocity: 0.0)
        
        var pointOfNoReturn: CGFloat!
        let leftOrigin: CGFloat = self.menuViews.rightContainerView.frame.origin.x
        
        if velocity.x >= 0.0 {
            pointOfNoReturn = (self.rootView.bounds.width - SliderMenuOptions.rightViewWidth) + SliderMenuOptions.pointOfNoReturnWidth
        } else {
            pointOfNoReturn = self.rootView.bounds.width - SliderMenuOptions.pointOfNoReturnWidth
        }
        
        panInfo.action = leftOrigin >= pointOfNoReturn ? .Close : .Open
        
        return panInfo
    }
    
    //
    // MARK: Find how much pixel was the translation
    //
    
    public func applyLeftGestureTranslation(translation: CGPoint, toFrame:CGRect) -> CGRect {
        var newOrigin: CGFloat = toFrame.origin.x
        newOrigin += translation.x
        
        let minOrigin: CGFloat = -SliderMenuOptions.rightViewWidth
        let maxOrigin: CGFloat = 0.0
        var newFrame: CGRect = toFrame
        
        if newOrigin < minOrigin {
            newOrigin = minOrigin
        } else if newOrigin > maxOrigin {
            newOrigin = maxOrigin
        }
        
        newFrame.origin.x = newOrigin
        return newFrame
    }
    
    public func applyRightGestureTranslation(translation: CGPoint, toFrame:CGRect) -> CGRect {
        var  newOrigin: CGFloat = toFrame.origin.x
        newOrigin += translation.x
        
        let minOrigin: CGFloat = self.rootView.frame.width - SliderMenuOptions.rightViewWidth
        let maxOrigin: CGFloat = self.rootView.frame.width
        var newFrame: CGRect = toFrame
        
        if newOrigin < minOrigin {
            newOrigin = minOrigin
        } else if newOrigin > maxOrigin {
            newOrigin = maxOrigin
        }
        
        newFrame.origin.x = newOrigin
        return newFrame
    }
}