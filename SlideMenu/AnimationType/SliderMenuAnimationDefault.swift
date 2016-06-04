//
//  SliderMenuAnimationDefault.swift
//  carrefour
//
//  Created by Edouard Roussillon on 6/3/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation

public class SliderMenuAnimationDefault: NSObject, SliderMenuAnimation {
    public var silderMenuGesture: SliderMenuGesture {
        get {
            return SliderMenuGestureDefault.sharedInstance
        }
    }
}