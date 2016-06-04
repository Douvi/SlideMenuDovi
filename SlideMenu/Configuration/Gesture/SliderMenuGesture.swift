//
//  AnimatorGesture.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/30/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import ObjectiveC
import UIKit

struct RightPanState {
    static var frameAtStartOfPan: CGRect = CGRectZero
    static var startPointOfPan: CGPoint = CGPoint.zero
    static var wasOpenAtStartOfPan: Bool = false
    static var wasHiddenAtStartOfPan: Bool = false
}



public protocol SliderMenuGesture:class, UIGestureRecognizerDelegate, GlobalVariables {
    var leftPanGesture: UIPanGestureRecognizer? {get set}
    var leftTapGesture: UITapGestureRecognizer? {get set}
    var rightPanGesture: UIPanGestureRecognizer? {get set}
    var rightTapGesture: UITapGestureRecognizer? {get set}
    
    func addLeftPanGestures()
    func addRightPanGestures()
    func removeLeftPanGestures()
    func removeRightPanGestures()
    
    func addLeftTapGestures()
    func addRightTapGestures()
    func removeLeftTapGestures()
    func removeRightTapGestures()
}

private var leftPanGestureKey: UInt8 = 0
private var leftTapGestureKey: UInt8 = 1
private var rightPanGestureKey: UInt8 = 2
private var rightTapGestureKey: UInt8 = 3

extension SliderMenuGesture  {
    
    public var leftPanGesture: UIPanGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &leftPanGestureKey) as? UIPanGestureRecognizer
        }
        
        set(newValue) {
            objc_setAssociatedObject(self, &leftPanGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public var leftTapGesture: UITapGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &leftTapGestureKey) as? UITapGestureRecognizer
        }
        
        set(newValue) {
            objc_setAssociatedObject(self, &leftTapGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public var rightPanGesture: UIPanGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &rightPanGestureKey) as? UIPanGestureRecognizer
        }
        
        set(newValue) {
            objc_setAssociatedObject(self, &rightPanGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public var rightTapGesture: UITapGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &rightTapGestureKey) as? UITapGestureRecognizer
        }
        
        set(newValue) {
            objc_setAssociatedObject(self, &rightTapGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

