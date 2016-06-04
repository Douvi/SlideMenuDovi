//
//  AnimatorChecker.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/31/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation

/**
 *  Check if menu open or close
 */
public protocol AnimatorChecker: GlobalVariables {
    func isLeftSideOpen() -> Bool
    func isLeftSideHidden() -> Bool
    func isRightSideOpen() -> Bool
    func isRightSideHidden() -> Bool
}

extension AnimatorChecker {
    public func isLeftSideOpen() -> Bool {
        return self.menuViews.mainContainerView.frame.origin.x == SliderMenuOptions.leftViewWidth
    }
    
    public func isLeftSideHidden() -> Bool {
        return self.menuViews.mainContainerView.frame.origin.x == 0
    }
    
    public func isRightSideOpen() -> Bool {
        return self.menuViews.mainContainerView.frame.origin.x == -SliderMenuOptions.rightViewWidth
    }
    
    public func isRightSideHidden() -> Bool {
        return self.menuViews.mainContainerView.frame.origin.x == 0
    }
}