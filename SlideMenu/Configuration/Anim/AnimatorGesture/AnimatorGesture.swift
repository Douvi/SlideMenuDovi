//
//  AnimatorGesture.swift
//  carrefour
//
//  Created by Edouard Roussillon on 6/1/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public struct LeftPanState {
    static var frameAtStartOfPan: CGRect = CGRect.zero
    static var startPointOfPan: CGPoint = CGPoint.zero
    static var wasOpenAtStartOfPan: Bool = false
    static var wasHiddenAtStartOfPan: Bool = false
}

public struct PanInfo {
    var action: SlideAction
    var shouldBounce: Bool
    var velocity: CGFloat
}

/**
 *  It will be call when the Pan gesture (left or right) is activated
 */
public protocol AnimatorGesture: GlobalVariables {
    func beganLeftTranslationGesture()
    func changedLeftTranslationGesture(frameTranslation: CGRect)
    func endLeftTranslationGesture(velocity: CGPoint) -> PanInfo

    func beganRightTranslationGesture()
    func changedRightTranslationGesture(frameTranslation: CGRect)
    func endRightTranslationGesture(velocity: CGPoint) -> PanInfo

    func applyLeftGestureTranslation(translation: CGPoint, toFrame:CGRect) -> CGRect
    func applyRightGestureTranslation(translation: CGPoint, toFrame:CGRect) -> CGRect
}

extension AnimatorGesture {

    //
    // MARK: Gesture Left
    //

    public func beganLeftTranslationGesture() {
        self.animationType.addShadowToView(self.menuViews.mainContainerView)
        self.menuViews.leftContainerView.frame.origin.x = 0.0
        self.menuViews.rightContainerView.frame.origin.x = self.rootView.frame.width
        LeftPanState.frameAtStartOfPan = self.menuViews.mainContainerView.frame
    }

    public func changedLeftTranslationGesture(frameTranslation: CGRect) {
        self.menuViews.mainContainerView.frame = frameTranslation
        self.menuViews.opacityView.frame = frameTranslation
        self.menuTools.applyLeftOpacity()
    }

    public func endLeftTranslationGesture(velocity: CGPoint) -> PanInfo {
        var panInfo: PanInfo = PanInfo(action: .Close, shouldBounce: false, velocity: 0.0)

        let thresholdVelocity: CGFloat = 1000.0
        var pointOfNoReturn: CGFloat!
        let leftOrigin: CGFloat = self.menuViews.mainContainerView.frame.origin.x

        if velocity.x <= 0.0 {
            pointOfNoReturn = SliderMenuOptions.leftViewWidth - SliderMenuOptions.pointOfNoReturnWidth
        } else {
            pointOfNoReturn = SliderMenuOptions.pointOfNoReturnWidth
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
        self.animationType.addShadowToView(self.menuViews.mainContainerView)
        self.menuViews.leftContainerView.frame.origin.x = -self.rootView.frame.width
        self.menuViews.rightContainerView.frame.origin.x = self.rootView.frame.width - SliderMenuOptions.rightViewWidth
        RightPanState.frameAtStartOfPan = self.menuViews.mainContainerView.frame
    }

    public func changedRightTranslationGesture(frameTranslation: CGRect) {
        self.menuViews.mainContainerView.frame = frameTranslation
        self.menuViews.opacityView.frame = frameTranslation
        self.menuTools.applyRightOpacity()
    }

    public func endRightTranslationGesture(velocity: CGPoint) -> PanInfo {
        var panInfo: PanInfo = PanInfo(action: .Close, shouldBounce: false, velocity: 0.0)

        var pointOfNoReturn: CGFloat!
        let leftOrigin: CGFloat = self.menuViews.mainContainerView.frame.origin.x

        if velocity.x >= 0.0 {
            pointOfNoReturn = -(SliderMenuOptions.rightViewWidth - SliderMenuOptions.pointOfNoReturnWidth)
        } else {
            pointOfNoReturn = -SliderMenuOptions.pointOfNoReturnWidth
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

        let minOrigin: CGFloat = 0.0
        let maxOrigin: CGFloat = SliderMenuOptions.leftViewWidth
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
}
