//
//  KIFUITestActor+identifier.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/17/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import XCTest
import KIF

extension KIFUITestActor {
    
    //
    // MARK: Find View
    //
    
    func tryFindingViewWithAccessibilityLabel(label: String) -> Bool {
        
        do {
            try self.tryFindingViewWithAccessibilityLabel(label, traits: UIAccessibilityTraitNone)
            return true
        } catch let _ as NSError {
              return false
        }
        
    }
    
    //
    // MARK: Wait for View
    //
    
    func waitForViewWithAccessibilityIdentifier(identifier: String) -> UIView? {
        return waitForTappableViewWithAccessibilityIdentifier(identifier, mustBeTappable: false)
    }
    
    func waitForTappableViewWithAccessibilityIdentifier(identifier: String) -> UIView? {
        return waitForTappableViewWithAccessibilityIdentifier(identifier, mustBeTappable: true)
    }
    
    private func waitForTappableViewWithAccessibilityIdentifier(identifier: String, mustBeTappable: Bool) -> UIView? {
        var view: UIView?
        self.waitForAccessibilityElement(nil, view: &view, withIdentifier: identifier, tappable: mustBeTappable)
        return view;
    }
    
    //
    // MARK: Tap into View
    //
    
    func tapViewWithAccessibilityIdentifier(identifier: String) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.waitForAccessibilityElement(&element, view: &view, withIdentifier: identifier, tappable: true)
        self.tapAccessibilityElement(element, inView:view)
    }
    
    //
    // MARK: Long Press into View
    //
    
    func longPressViewWithAccessibilityIdentifier(identifier: String, duration:NSTimeInterval) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.waitForAccessibilityElement(&element, view: &view, withIdentifier: identifier, tappable: true)
        self.longPressAccessibilityElement(element, inView:view, duration:duration)
    }
    
    //
    // MARK: Enter text
    //
    
    func enterText(text: String, intoViewWithAccessibilityIdentifier identifier: String, expectedResult: String? = nil) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.waitForAccessibilityElement(&element, view: &view, withIdentifier: identifier, tappable: true)
    
        self.enterText(text, intoElement: element, inView: view, expectedResult:expectedResult)
    }
    
    private func enterText(text: String, intoElement element: UIAccessibilityElement, inView view: UIView, expectedResult: String?) {
        // In iOS7, tapping a field that is already first responder moves the cursor to the front of the field
//        if view.window!.firstResponder != view {
//            self.tapAccessibilityElement(element, inView: view)
//            self.waitForTimeInterval(0.25)
//        }
    
        self.enterTextIntoCurrentFirstResponder(text, fallbackView: view)
        self.expectView(view, toContainText: expectedResult ?? text)
    }
    
    //
    // MARK: Clear Text
    //
    
    func clearTextFromViewWithAccessibilityIdentifier(identifier: String)
    {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.waitForAccessibilityElement(&element, view: &view, withIdentifier: identifier, tappable: true)
        self.clearTextFromElement(element, inView: view)
    }
    
    func clearTextFromAndThenEnterText(text: String, intoViewWithAccessibilityIdentifier identifier: String, expectedResult: String?) {
        self.clearTextFromViewWithAccessibilityIdentifier(identifier)
        self.enterText(text, intoViewWithAccessibilityIdentifier: identifier, expectedResult: expectedResult)
    }
    
    //
    // MARK: Switer
    //
    
    func setOn(switchIsOn: Bool, intoViewWithAccessibilityIdentifier identifier: String) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.waitForAccessibilityElement(&element, view: &view, withIdentifier: identifier, tappable: true)
        
        if let switchView = view as? UISwitch {
            self.setSwitch(switchView, element: element, on: switchIsOn);
        }
    }
    
    //
    // MARK: Slider
    //
    
    func setValue(value: Float, intoViewWithAccessibilityIdentifier identifier: String) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.waitForAccessibilityElement(&element, view: &view, withIdentifier: identifier, tappable: true)
    
        if let slider = view as? UISlider {
            self.setValue(value, forSlider:slider)
        }
    }
    
    //
    // MARK: Swipe into view
    //
    
    func swipeViewWithAccessibilityIdentifier(identifier: String, inDirection direction:KIFSwipeDirection) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.waitForAccessibilityElement(&element, view: &view, withIdentifier: identifier, tappable: true)
        
        self.swipeAccessibilityElement(element, inView:view, inDirection:direction)
    }

    //
    // MARK: Pull to request
    //
    
    func pullToRefreshViewWithAccessibilityIdentifier(identifier: String) {
        self.pullToRefreshViewWithAccessibilityIdentifier(identifier, pullDownDuration: KIFPullToRefreshTiming.InAboutAHalfSecond)
    }
    
    func pullToRefreshViewWithAccessibilityIdentifier(identifier: String, pullDownDuration: KIFPullToRefreshTiming) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.waitForAccessibilityElement(&element, view: &view, withIdentifier: identifier, tappable: true)
        
        self.pullToRefreshAccessibilityElement(element, inView: view, pullDownDuration: pullDownDuration)
    }
    
    //
    // MARK: Tap Stepper
    //
    
    func tapStepperWithAccessibilityIdentifier(identifier: String, increment stepperDirection: KIFStepperDirection) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.waitForAccessibilityElement(&element, view: &view, withIdentifier: identifier, tappable: true)
        self.tapStepperWithAccessibilityElement(element, increment: stepperDirection, inView: view)
    }
    
    //
    // MARK: Tap link
    //
    
    func tapTextIntoLabel(text: String, inTextViewWithAccessibilityIdentifier identifier: String) {
        self.runBlock() { (error) -> KIFTestStepResult in
            var view: UIView?
            var element: UIAccessibilityElement?
            self.waitForAccessibilityElement(&element, view: &view, withIdentifier: identifier, tappable: true)
            
            if let label = view as? UILabel,
                let attributed = label.attributedText,
                let originalText = label.text,
                let toRange: NSRange = (originalText as NSString).rangeOfString(text),
                let size = view?.frame.size {
                
                let textStorage = NSTextStorage(attributedString: attributed)
                let layoutManager = NSLayoutManager()
                textStorage.addLayoutManager(layoutManager)
                
                let textContainer = NSTextContainer(size: size)
                layoutManager.addTextContainer(textContainer)
                textContainer.lineFragmentPadding = 0
                textContainer.lineBreakMode = label.lineBreakMode
                
                let glyphRange = layoutManager.glyphRangeForCharacterRange(toRange, actualCharacterRange: nil)
                let glyphRect = layoutManager.boundingRectForGlyphRange(glyphRange, inTextContainer: textContainer)
                
                let point:CGPoint = CGPointMake(glyphRect.origin.x + 10, (glyphRect.origin.y + glyphRect.size.height) - 10);

                let testView = UIView(frame: CGRectMake(point.x, point.y, 4, 4))
                testView.backgroundColor = UIColor.redColor()
                label.addSubview(testView)
                
                view!.longPressAtPoint(point, duration:0.1)
                
                return KIFTestStepResult.Success
            } else {
//                KIFTestCondition(view as? UILabel, error, "The accessibility element is not a UILabel");
                return KIFTestStepResult.Failure
            }
            
        }
    }
    
}