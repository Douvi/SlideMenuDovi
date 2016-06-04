//
//  SliderMenuOption.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/30/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit


public enum SlideAction {
    case Open
    case Close
}

public enum TrackAction {
    case TapOpen
    case TapClose
    case FlickOpen
    case FlickClose
}

public struct SliderMenuOptions {
    public static var leftViewWidth: CGFloat = 242.0
    public static var leftBezelWidth: CGFloat = 16.0
    public static var leftPanFromBezel: Bool = true
    
    public static var animationType: SliderMenuAnimation = SliderMenuAnimationDefault()
    public static var contentViewScale: CGFloat = 0.0
    public static var contentViewOpacity: CGFloat = 0.0
    public static var shadowOpacity: CGFloat = 1.0
    public static var shadowRadius: CGFloat = 12
    public static var shadowOffset: CGSize = CGSizeMake(0,0)
    public static var shadowColor: UIColor = UIColor.blackColor()
    
    public static var animationDuration: CGFloat = 0.4
    public static var rightViewWidth: CGFloat = 242.0
    public static var rightBezelWidth: CGFloat = 16.0
    public static var rightPanFromBezel: Bool = true
    public static var hideStatusBar: Bool = false
    public static var pointOfNoReturnWidth: CGFloat = 44.0
    public static var showsStatusBarBackground: Bool = false
    public static var statusBarBackgroundColor: UIColor = UIColor.clearColor()
}