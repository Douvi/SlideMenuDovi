//
//  MenuTools.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/30/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public class MenuTools {
    public static let sharedInstance: MenuTools = MenuTools()
    
    var rootView: UIView!
    let menuViews = MenuViews()
    let menuViewControllers = MenuViewControllers()
    
    // Private constructor
    private init() {}
    
    /*
    *   Tools
    */
    
    public func leftMinOrigin() -> CGFloat {
        return  -SliderMenuOptions.leftViewWidth
    }
    
    public func rightMinOrigin(frame: CGRect) -> CGFloat {
        return CGRectGetWidth(frame)
    }
    
    //
    //  MARK: Window Level
    //
    
    public func setCloseWindowLevel() {
        if SliderMenuOptions.hideStatusBar {
            dispatch_async(dispatch_get_main_queue(), {
                if let window = UIApplication.sharedApplication().keyWindow {
                    window.windowLevel = UIWindowLevelNormal
                }
            })
        }
    }
    
    public func setOpenWindowLevel() {
        if SliderMenuOptions.hideStatusBar {
            dispatch_async(dispatch_get_main_queue(), {
                if let window = UIApplication.sharedApplication().keyWindow {
                    window.windowLevel = UIWindowLevelStatusBar + 1
                }
            })
        }
    }
    
    //
    //  MARK: Main Container Interaction
    //
    
    public func disableContentInteraction() {
        menuViews.mainContainerView.userInteractionEnabled = false
    }
    
    public func enableContentInteraction() {
        menuViews.mainContainerView.userInteractionEnabled = true
    }
    
    //
    // MARK: add or remove Shadow
    //
    
    public func addShadowToView(targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = false
        targetContainerView.layer.shadowColor = SliderMenuOptions.shadowColor.CGColor
        targetContainerView.layer.shadowOffset = SliderMenuOptions.shadowOffset
        targetContainerView.layer.shadowOpacity = Float(SliderMenuOptions.shadowOpacity)
        targetContainerView.layer.shadowRadius = SliderMenuOptions.shadowRadius
        targetContainerView.layer.shadowPath = UIBezierPath(rect: targetContainerView.bounds).CGPath
    }
    
    public func removeShadow(targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = true
        self.menuViews.mainContainerView.layer.opacity = 1.0
    }
    
    //
    // MARK: Opacity
    //
    
    public func applyLeftOpacity() {
        let openedLeftRatio: CGFloat = getOpenedLeftRatio()
        let opacity: CGFloat = SliderMenuOptions.contentViewOpacity * openedLeftRatio
        self.menuViews.opacityView.layer.opacity = Float(opacity)
    }
    
    public func applyRightOpacity() {
        let openedRightRatio: CGFloat = getOpenedRightRatio()
        let opacity: CGFloat = SliderMenuOptions.contentViewOpacity * openedRightRatio
        self.menuViews.opacityView.layer.opacity = Float(opacity)
    }
    
    //
    // MARK: Private
    //
    
    private func getOpenedLeftRatio() -> CGFloat {
        let width: CGFloat = self.menuViews.leftContainerView.frame.size.width
        let currentPosition: CGFloat = self.menuViews.leftContainerView.frame.origin.x - leftMinOrigin()
        return currentPosition / width
    }
    
    private func getOpenedRightRatio() -> CGFloat {
        let width: CGFloat = self.menuViews.rightContainerView.frame.size.width
        let currentPosition: CGFloat = self.menuViews.rightContainerView.frame.origin.x
        return -(currentPosition - CGRectGetWidth(self.rootView.bounds)) / width
    }
}

