//
//  GlobalVariable.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/31/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public protocol GlobalVariables: class {
    var rootView: UIView { get }
    var menuTools: MenuTools { get }
    var menuViews: MenuViews { get }
    var menuViewControllers: MenuViewControllers { get }
    var animationType: SliderMenuAnimation { get }
    var gesture: SliderMenuGesture { get }
    var leftViewController: UIViewController? { get }
    var rightViewController: UIViewController? { get }
    var mainViewController: UIViewController? { get }
}

extension GlobalVariables {
    public var rootView: UIView {
        get {
            return menuTools.rootView
        }
    }
    
    public var menuTools: MenuTools {
        get {
            return MenuTools.sharedInstance
        }
    }
    
    public var menuViews: MenuViews {
        get {
            return menuTools.menuViews
        }
    }
    
    public var menuViewControllers: MenuViewControllers {
        get {
            return menuTools.menuViewControllers
        }
    }
    
    public var animationType: SliderMenuAnimation {
        get {
            return SliderMenuOptions.animationType
        }
    }
    
    public var gesture: SliderMenuGesture {
        get {
            return animationType.silderMenuGesture
        }
    }
    
    public var leftViewController: UIViewController? {
        get {
            return menuViewControllers.leftViewController
        }
    }
    
    public var rightViewController: UIViewController? {
        get {
            return menuViewControllers.rightViewController
        }
    }
    
    public var mainViewController: UIViewController? {
        get {
            return menuViewControllers.mainViewController
        }
    }
}