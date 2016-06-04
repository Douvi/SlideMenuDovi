//
//  AnimatorCheckerSliderOver.swift
//  carrefour
//
//  Created by Edouard Roussillon on 6/3/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public protocol AnimatorCheckerSliderOver: AnimatorChecker {
}

extension AnimatorCheckerSliderOver {
    public func isLeftSideOpen() -> Bool {
        return self.menuViews.leftContainerView.frame.origin.x == 0
    }
    
    public func isLeftSideHidden() -> Bool {
        return self.menuViews.leftContainerView.frame.origin.x == -SliderMenuOptions.leftViewWidth
    }
    
    public func isRightSideOpen() -> Bool {
        return self.menuViews.rightContainerView.frame.origin.x == self.rootView.bounds.width - SliderMenuOptions.rightViewWidth
    }
    
    public func isRightSideHidden() -> Bool {
        return self.menuViews.mainContainerView.frame.origin.x == self.rootView.bounds.width
    }
}