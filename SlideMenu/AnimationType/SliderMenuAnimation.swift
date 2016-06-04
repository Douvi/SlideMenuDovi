//
//  SliderMenuAnimation.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/30/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation

public protocol SliderMenuAnimation: AnimatorChecker, AnimatorFire, AnimatorGesture, AnimatorVector {
    var silderMenuGesture: SliderMenuGesture { get }
    func orderList()
}

extension SliderMenuAnimation  {
    
    public func orderList() {
        rootView.addSubview(self.menuViews.rightContainerView)
        rootView.addSubview(self.menuViews.leftContainerView)
        rootView.addSubview(self.menuViews.mainContainerView)
        rootView.addSubview(self.menuViews.opacityView)
        
        if SliderMenuOptions.showsStatusBarBackground {
            rootView.addSubview(self.menuViews.statusBarView)
        }
    }

    

}