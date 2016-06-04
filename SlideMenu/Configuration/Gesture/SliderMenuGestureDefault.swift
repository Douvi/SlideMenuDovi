//
//  SliderMenuGestureDefault.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/31/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public class SliderMenuGestureDefault: NSObject, SliderMenuGesture {
    public static let sharedInstance: SliderMenuGestureDefault = SliderMenuGestureDefault()
    
    private override init() {}
    
    
    public func addLeftPanGestures() {
        if menuViewControllers.leftViewController != nil {
            if self.leftPanGesture == nil {
                self.leftPanGesture = UIPanGestureRecognizer(target: self, action: #selector(SliderMenuGestureDefault.handleLeftPanGesture(_:)))
                self.leftPanGesture!.delegate = self
                self.rootView.addGestureRecognizer(self.leftPanGesture!)
            }
        }
    }
    
    public func addRightPanGestures() {
        if menuViewControllers.rightViewController != nil {
            if self.rightPanGesture == nil {
                self.rightPanGesture = UIPanGestureRecognizer(target: self, action: #selector(SliderMenuGestureDefault.handleRightPanGesture(_:)))
                self.rightPanGesture!.delegate = self
                self.rootView.addGestureRecognizer(self.rightPanGesture!)
            }
        }
    }
    
    public func removeLeftPanGestures() {
        if leftPanGesture != nil {
            self.rootView.removeGestureRecognizer(leftPanGesture!)
            leftPanGesture = nil
        }
    }
    
    public func removeRightPanGestures() {
        if rightPanGesture != nil {
            self.rootView.removeGestureRecognizer(rightPanGesture!)
            rightPanGesture = nil
        }
    }
    
    public func addLeftTapGestures() {
        if menuViewControllers.leftViewController != nil {
            
            if self.leftTapGesture == nil {
                self.leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(SliderMenuGestureDefault.handleLeftTapGesture))
                self.leftTapGesture!.delegate = self
                self.rootView.addGestureRecognizer(leftTapGesture!)
            }
        }
    }
    
    public func addRightTapGestures() {
        if menuViewControllers.rightViewController != nil {
            if self.rightTapGesture == nil {
                self.rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(SliderMenuGestureDefault.handleRightTapGesture))
                self.rightTapGesture!.delegate = self
                self.rootView.addGestureRecognizer(self.rightTapGesture!)
            }
        }
    }
    
    public func removeLeftTapGestures() {
        if leftTapGesture != nil {
            self.rootView.removeGestureRecognizer(leftTapGesture!)
            leftTapGesture = nil
        }
    }
    
    public func removeRightTapGestures() {
        if rightTapGesture != nil {
            self.rootView.removeGestureRecognizer(rightTapGesture!)
            rightTapGesture = nil
        }
    }
    
    //
    // MARK: UIPanGestureRecognizer
    //
    
    public func handleLeftPanGesture(panGesture: UIPanGestureRecognizer) {
        
        if self.animationType.isRightSideOpen() {
            return
        }

        switch panGesture.state {
        case UIGestureRecognizerState.Began:
            self.animationType.beganLeftTranslationGesture()
            LeftPanState.startPointOfPan = panGesture.locationInView(self.rootView)
            LeftPanState.wasOpenAtStartOfPan = self.animationType.isLeftSideOpen()
            LeftPanState.wasHiddenAtStartOfPan = self.animationType.isLeftSideHidden()

            self.menuViewControllers.leftViewController?.beginAppearanceTransition(LeftPanState.wasHiddenAtStartOfPan, animated: true)
            self.menuTools.setOpenWindowLevel()
        case UIGestureRecognizerState.Changed:
            
            let translation: CGPoint = panGesture.translationInView(panGesture.view!)
            let frameTranslation = self.animationType.applyLeftGestureTranslation(translation, toFrame: LeftPanState.frameAtStartOfPan)
            self.animationType.changedLeftTranslationGesture(frameTranslation)

        case UIGestureRecognizerState.Ended:

            let velocity: CGPoint = panGesture.velocityInView(panGesture.view)
            let panInfo: PanInfo = self.animationType.endLeftTranslationGesture(velocity)

            if panInfo.action == .Open {
                self.menuViewControllers.leftViewController?.endAppearanceTransition()
                self.animationType.openLeftWithVelocity(panInfo.velocity)
//                track(.FlickOpen)
            } else {
                self.menuViewControllers.leftViewController?.endAppearanceTransition()
                self.animationType.closeLeftWithVelocity(panInfo.velocity)
                self.menuTools.setCloseWindowLevel()
//                track(.FlickClose)
            }
        default:
            break
        }
    }
    
    public func handleRightPanGesture(panGesture: UIPanGestureRecognizer) {
        
        if self.animationType.isLeftSideOpen() {
            return
        }
        
        switch panGesture.state {
        case UIGestureRecognizerState.Began:
            self.animationType.beganRightTranslationGesture()
            RightPanState.startPointOfPan = panGesture.locationInView(self.rootView)
            RightPanState.wasOpenAtStartOfPan =  self.animationType.isRightSideOpen()
            RightPanState.wasHiddenAtStartOfPan = self.animationType.isRightSideHidden()
            
            self.menuViewControllers.rightViewController?.beginAppearanceTransition(RightPanState.wasHiddenAtStartOfPan, animated: true)
            self.menuTools.setOpenWindowLevel()
        case UIGestureRecognizerState.Changed:
            
            let translation: CGPoint = panGesture.translationInView(panGesture.view!)
            let frameTranslation = self.animationType.applyRightGestureTranslation(translation, toFrame: RightPanState.frameAtStartOfPan)
            self.animationType.changedRightTranslationGesture(frameTranslation)
            
        case UIGestureRecognizerState.Ended:
            
            let velocity: CGPoint = panGesture.velocityInView(panGesture.view)
            let panInfo: PanInfo = self.animationType.endRightTranslationGesture(velocity)
            
            if panInfo.action == .Open {
                if !RightPanState.wasHiddenAtStartOfPan {
                    self.menuViewControllers.rightViewController?.beginAppearanceTransition(true, animated: true)
                }
                self.animationType.openRightWithVelocity(panInfo.velocity)
            } else {
                if RightPanState.wasHiddenAtStartOfPan {
                    self.menuViewControllers.rightViewController?.beginAppearanceTransition(false, animated: true)
                }
                self.animationType.closeRightWithVelocity(panInfo.velocity)
                self.menuTools.setCloseWindowLevel()
            }
        default:
            break
        }
    }
    
    public func handleLeftTapGesture() {
        self.animationType.toggleLeft()
    }
    
    public func handleRightTapGesture() {
        self.animationType.toggleRight()
    }
    
    //
    // MARK: UIGestureRecognizerDelegate
    //
    
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        let point: CGPoint = touch.locationInView(self.rootView)
        
        if gestureRecognizer == leftPanGesture {
            return slideLeftForGestureRecognizer(gestureRecognizer, point: point)
        } else if gestureRecognizer == rightPanGesture {
            return slideRightViewForGestureRecognizer(gestureRecognizer, withTouchPoint: point)
        } else if gestureRecognizer == leftTapGesture {
            return self.animationType.isLeftSideOpen() && !isPointContainedWithinLeftRect(point)
        } else if gestureRecognizer == rightTapGesture {
            return self.animationType.isRightSideOpen() && !isPointContainedWithinRightRect(point)
        }
        
        return false
    }

    private func slideLeftForGestureRecognizer( gesture: UIGestureRecognizer, point:CGPoint) -> Bool {
        return self.animationType.isLeftSideOpen() || SliderMenuOptions.leftPanFromBezel && isLeftPointContainedWithinBezelRect(point)
    }
    
    private func slideRightViewForGestureRecognizer(gesture: UIGestureRecognizer, withTouchPoint point: CGPoint) -> Bool {
        return self.animationType.isRightSideOpen() || SliderMenuOptions.rightPanFromBezel && isRightPointContainedWithinBezelRect(point)
    }

    private func isPointContainedWithinLeftRect(point: CGPoint) -> Bool {
        return CGRectContainsPoint(self.menuViews.leftContainerView.frame, point)
    }
    
    private func isPointContainedWithinRightRect(point: CGPoint) -> Bool {
        return CGRectContainsPoint(self.menuViews.rightContainerView.frame, point)
    }

    private func isLeftPointContainedWithinBezelRect(point: CGPoint) -> Bool {
        return point.x <= SliderMenuOptions.leftBezelWidth
    }

    private func isRightPointContainedWithinBezelRect(point: CGPoint) -> Bool {
        let lastPoint = self.rootView.bounds.width - SliderMenuOptions.rightBezelWidth
        return point.x >= lastPoint
    }
}