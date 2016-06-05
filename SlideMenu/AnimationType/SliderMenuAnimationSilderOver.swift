//
//  SliderMenuAnimationSilderOver.swift
//  carrefour
//
//  Created by Edouard Roussillon on 6/3/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation

public class SliderMenuAnimationSliderOver: NSObject, SliderMenuAnimation, AnimatorCheckerSliderOver, AnimatorFireSlideOver, AnimatorVectorSlideOver, AnimatorGestureSlideOver {
    public var silderMenuGesture: SliderMenuGesture {
        get {
            return SliderMenuGestureDefault.sharedInstance
        }
    }

    public func orderList() {
        rootView.addSubview(self.menuViews.mainContainerView)
        rootView.addSubview(self.menuViews.opacityView)
        rootView.addSubview(self.menuViews.rightContainerView)
        rootView.addSubview(self.menuViews.leftContainerView)

        if SliderMenuOptions.showsStatusBarBackground {
            rootView.addSubview(self.menuViews.statusBarView)
        }

    }
}
