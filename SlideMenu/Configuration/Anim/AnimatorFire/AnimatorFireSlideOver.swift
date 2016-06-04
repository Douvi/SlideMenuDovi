//
//  AnimatorFireSlideOver.swift
//  carrefour
//
//  Created by Edouard Roussillon on 6/3/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public protocol AnimatorFireSlideOver: AnimatorFire {}

extension AnimatorFireSlideOver {
    
    //
    // MARK: Animation Slider
    //
    
    public func animateLeftSideToOpen() {
        self.menuViews.rightContainerView.frame.origin.x = self.rootView.bounds.width
        self.menuViews.mainContainerView.frame.origin.x = 0
        self.animationType.openLeftWithVelocity(0.0)
    }
    
    public func animateLeftSideToClose() {
        self.animationType.closeLeftWithVelocity(-SliderMenuOptions.leftViewWidth)
    }
    
    public func animateRightSideToOpen() {
        let x = (self.rootView.bounds.width - SliderMenuOptions.rightViewWidth)
        
        self.menuViews.leftContainerView.frame.origin.x = -SliderMenuOptions.leftViewWidth
        self.menuViews.mainContainerView.frame.origin.x = 0
        self.animationType.openRightWithVelocity(x)
    }
    
    public func animateRightSideToClose() {
        self.animationType.closeRightWithVelocity(self.rootView.bounds.width)
    }
    
}