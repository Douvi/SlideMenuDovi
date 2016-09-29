//
//  AnimatorFire.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/31/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

/**
 *  It will fire the animation
 */
public protocol AnimatorFire: GlobalVariables {
    func toggleLeft()
    func toggleRight()

    func closeLeft()
    func closeRight()

    func openLeft()
    func openRight()

    func addShadowToView(targetContainerView: UIView)
    func removeShadow(targetContainerView: UIView)

    func animateLeftSideToOpen()
    func animateLeftSideToClose()
    func animateRightSideToOpen()
    func animateRightSideToClose()
}

extension AnimatorFire {

    public func toggleLeft() {
        if self.animationType.isLeftSideOpen() {
            self.closeLeft()
        } else {
            self.openLeft()
        }
    }

    public func toggleRight() {
        if self.animationType.isRightSideOpen() {
            self.closeRight()
        } else {
            self.openRight()
        }
    }

    public func closeLeft() {
        let isLeftClose = self.animationType.isLeftSideHidden()
        self.menuViewControllers.leftViewController?.beginAppearanceTransition(isLeftClose, animated: true)

        self.animateLeftSideToClose()

        self.menuTools.setCloseWindowLevel()
    }

    public func closeRight() {
        let isRightClose = self.animationType.isRightSideHidden()
        self.menuViewControllers.rightViewController?.beginAppearanceTransition(isRightClose, animated: true)

        self.animateRightSideToClose()

        self.menuTools.setCloseWindowLevel()
    }

    public func openLeft() {
        self.menuTools.setOpenWindowLevel()

        let isLeftClose = self.animationType.isLeftSideHidden()
        self.menuViewControllers.leftViewController?.beginAppearanceTransition(isLeftClose, animated: true)

        self.animateLeftSideToOpen()
    }

    public func openRight() {
        self.menuTools.setOpenWindowLevel()

        let isRightClose = self.animationType.isRightSideHidden()
        self.menuViewControllers.rightViewController?.beginAppearanceTransition(isRightClose, animated: true)

        self.animateRightSideToOpen()
    }

    //
    // MARK: Add Remove Shadow
    //

    public func addShadowToView(targetContainerView: UIView) {
        self.menuTools.addShadowToView(targetContainerView)
    }

    public func removeShadow(targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = true
        self.menuViews.mainContainerView.layer.opacity = 1.0
    }


    //
    // MARK: Animation Side
    //

    public func animateLeftSideToOpen() {
        self.menuViews.leftContainerView.frame.origin.x = 0
        self.animationType.openLeftWithVelocity(SliderMenuOptions.leftViewWidth)
    }

    public func animateLeftSideToClose() {
        self.animationType.closeLeftWithVelocity(0.0)
    }

    public func animateRightSideToOpen() {
        self.menuViews.leftContainerView.frame.origin.x = -self.rootView.bounds.width
        self.menuViews.rightContainerView.frame.origin.x = self.rootView.bounds.width - SliderMenuOptions.rightViewWidth
        self.animationType.openRightWithVelocity(-SliderMenuOptions.rightViewWidth)
    }

    public func animateRightSideToClose() {
        self.animationType.closeRightWithVelocity(0.0)
    }
}
