//
//  GlobalVariable.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/31/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public enum TrackAction {
    case LeftWillOpen
    case LeftWillClose
    case RightWillOpen
    case RightWillClose
    case LeftDidOpen
    case LeftDidClose
    case RightDidOpen
    case RightDidClose
}

/**
 *  Give you access to all you need
 */
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
    
    public func sendNotification(trackAction: TrackAction) {
        print("TrackAction - \(trackAction)")
        switch trackAction {
        case .LeftWillOpen:
            NSNotificationCenter.defaultCenter().postNotificationName(TrackActionNotification.MenuLeftWillOpen.rawValue, object: nil)
            break
        case .LeftDidOpen:
            NSNotificationCenter.defaultCenter().postNotificationName(TrackActionNotification.MenuLeftDidOpen.rawValue, object: nil)
            break
        case .LeftWillClose:
            NSNotificationCenter.defaultCenter().postNotificationName(TrackActionNotification.MenuLeftWillClose.rawValue, object: nil)
            break
        case .LeftDidClose:
            NSNotificationCenter.defaultCenter().postNotificationName(TrackActionNotification.MenuLeftDidClose.rawValue, object: nil)
            break
        case .RightWillOpen:
            NSNotificationCenter.defaultCenter().postNotificationName(TrackActionNotification.MenuRightWillOpen.rawValue, object: nil)
            break
        case .RightDidOpen:
            NSNotificationCenter.defaultCenter().postNotificationName(TrackActionNotification.MenuRightDidOpen.rawValue, object: nil)
            break
        case .RightWillClose:
            NSNotificationCenter.defaultCenter().postNotificationName(TrackActionNotification.MenuRightWillClose.rawValue, object: nil)
            break
        case .RightDidClose:
            NSNotificationCenter.defaultCenter().postNotificationName(TrackActionNotification.MenuRightDidClose.rawValue, object: nil)
            break
        }
        
    }
}
