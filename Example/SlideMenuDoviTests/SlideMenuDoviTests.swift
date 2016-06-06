//
//  SlideMenuDoviTests.swift
//  carrefour
//
//  Created by Edouard Roussillon on 4/27/16.
//  Copyright © 2016 Edouard Roussillon. All rights reserved.
//

import UIKit
import Nimble
import Quick
import KIF

@testable import SlideMenuDovi

public class SlideMenuDoviTests: QuickSpec {
    private var navRootViewController: UINavigationController!
    private var listAnimationViewController: ListAnimationViewController!
    private var rootViewController: RootViewController!
    private var mainViewController: MainViewController!
    
    private let listButtonAnimDefault = "list_button_anim_default"
    private let listButtonAnimSliderOver = "list_button_anim_slider_over"
    private let mainButtonLeft = "main_button_left"
    private let mainButtonClose = "main_button_close"
    private let mainButtonRight = "main_button_right"
    private let rootViewRoot = "root_view_root"
    
    public override func spec() {
        super.spec()
        
        describe("Check all behavior SliderMenu") {
            
            describe("Check behavior Default") {
                
                beforeEach {
                    self.startViewController()
                    self.clickButton(self.listButtonAnimDefault)
                    self.wait()
                    self.initRootViewController()
                }
                
                afterEach {
                    self.clickButton(self.mainButtonClose)
                    self.wait()
                    let vc = self.listAnimationViewController.presentedViewController
                    expect(vc).to(beNil())
                }
                
                it("open and close left side by tap") {
                    self.clickButton(self.mainButtonLeft)
                    expect(self.mainViewController.isSlideMenuLeftOpen()).to(equal(true))
                    self.clickRightSide()
                    expect(self.mainViewController.isSlideMenuLeftOpen()).to(equal(false))
                }
                
                it("open and close left side by swipe") {
                    self.swipeLeftToRight()
                    self.wait(seconds: 2)
                    expect(self.mainViewController.isSlideMenuLeftOpen()).to(equal(true))
                    self.tester.swipeViewWithAccessibilityIdentifier(self.rootViewRoot, inDirection: KIFSwipeDirection.Left)
                    self.wait(seconds: 2)
                    expect(self.mainViewController.isSlideMenuLeftOpen()).to(equal(false))
                }

                it("open and close right side by tap") {
                    self.clickButton(self.mainButtonRight)
                    self.wait()
                    expect(self.mainViewController.isSlideMenuRightOpen()).to(equal(true))
                    self.clickLeftSide()
                    expect(self.mainViewController.isSlideMenuRightOpen()).to(equal(false))
                }

                it("open and close right side by swipe") {
                    self.swipeRightToLeft()
                    self.wait()
                    expect(self.mainViewController.isSlideMenuRightOpen()).to(equal(true))
                    self.tester.swipeViewWithAccessibilityIdentifier(self.rootViewRoot, inDirection: KIFSwipeDirection.Right)
                    self.wait()
                    expect(self.mainViewController.isSlideMenuRightOpen()).to(equal(false))
                }
            }
            
            describe("Check behavior Slide Over") {
                
                beforeEach {
                    self.startViewController()
                    self.clickButton(self.listButtonAnimSliderOver)
                    self.wait()
                    self.initRootViewController()
                }
                
                afterEach {
                    self.clickButton(self.mainButtonClose)
                    self.wait()
                    let vc = self.listAnimationViewController.presentedViewController
                    expect(vc).to(beNil())
                }
                
                it("open and close left side by tap") {
                    self.clickButton(self.mainButtonLeft)
                    expect(self.mainViewController.isSlideMenuLeftOpen()).to(equal(true))
                    self.clickRightSide()
                    expect(self.mainViewController.isSlideMenuLeftOpen()).to(equal(false))
                }
                
                it("open and close left side by swipe") {
                    self.swipeLeftToRight()
                    self.wait(seconds: 2)
                    expect(self.mainViewController.isSlideMenuLeftOpen()).to(equal(true))
                    self.tester.swipeViewWithAccessibilityIdentifier(self.rootViewRoot, inDirection: KIFSwipeDirection.Left)
                    self.wait(seconds: 2)
                    expect(self.mainViewController.isSlideMenuLeftOpen()).to(equal(false))
                }
                
                it("open and close right side by tap") {
                    self.clickButton(self.mainButtonRight)
                    self.wait()
                    expect(self.mainViewController.isSlideMenuRightOpen()).to(equal(true))
                    self.clickLeftSide()
                    expect(self.mainViewController.isSlideMenuRightOpen()).to(equal(false))
                }
                
                it("open and close right side by swipe") {
                    self.swipeRightToLeft()
                    self.wait()
                    expect(self.mainViewController.isSlideMenuRightOpen()).to(equal(true))
                    self.tester.swipeViewWithAccessibilityIdentifier(self.rootViewRoot, inDirection: KIFSwipeDirection.Right)
                    self.wait()
                    expect(self.mainViewController.isSlideMenuRightOpen()).to(equal(false))
                }
            }
    
            describe("Fire by code") {
                
                beforeEach {
                    self.startViewController()
                    self.clickButton(self.listButtonAnimSliderOver)
                    self.wait()
                    self.initRootViewController()
                }
                
                afterEach {
                    self.clickButton(self.mainButtonClose)
                    self.wait()
                    let vc = self.listAnimationViewController.presentedViewController
                    expect(vc).to(beNil())
                }
                
                it("toggle left slider") {
                    self.mainViewController.toggleSlideMenuLeft()
                    self.wait()
                    expect(self.mainViewController.isSlideMenuLeftOpen()).to(equal(true))
                    self.mainViewController.toggleSlideMenuLeft()
                    self.wait()
                    expect(self.mainViewController.isSlideMenuLeftOpen()).to(equal(false))
                }
                
                it("toggle right slider") {
                    self.mainViewController.toggleSlideMenuRight()
                    self.wait()
                    expect(self.mainViewController.isSlideMenuRightOpen()).to(equal(true))
                    self.mainViewController.toggleSlideMenuRight()
                    self.wait()
                    expect(self.mainViewController.isSlideMenuRightOpen()).to(equal(false))
                }
                
                it("toggle and close left slider") {
                    self.mainViewController.toggleSlideMenuLeft()
                    self.wait()
                    expect(self.mainViewController.isSlideMenuLeftOpen()).to(equal(true))
                    self.mainViewController.closeSlideMenuLeft()
                    self.wait()
                    expect(self.mainViewController.isSlideMenuLeftOpen()).to(equal(false))
                }
                
                it("toggle and close right slider") {
                    self.mainViewController.toggleSlideMenuRight()
                    self.wait()
                    expect(self.mainViewController.isSlideMenuRightOpen()).to(equal(true))
                    self.mainViewController.closeSlideMenuRight()
                    self.wait()
                    expect(self.mainViewController.isSlideMenuRightOpen()).to(equal(false))
                }
            }
        }
    }
    
    private func clickRightSide() {
        let x = self.navRootViewController.view.bounds.width - 10
        let y = self.navRootViewController.view.bounds.height / 2
        
        let point:CGPoint = CGPointMake(x, y);
        self.rootViewController.view.longPressAtPoint(point, duration:0.1)
    }
    
    private func clickLeftSide() {
        let x:CGFloat = 10
        let y = self.navRootViewController.view.bounds.height / 2
        
        let point:CGPoint = CGPointMake(x, y);
        self.rootViewController.view.longPressAtPoint(point, duration:0.1)
    }
    
    private func swipeLeftToRight() {
        let x:CGFloat = 0
        let y = self.navRootViewController.view.bounds.height / 2
        let point:CGPoint = CGPointMake(x, y);
        
        let xTo:CGFloat = self.navRootViewController.view.bounds.width / 2
        let yTo:CGFloat = 0
        let point2:CGPoint = CGPointMake(xTo, yTo);
        
        self.rootViewController.view.dragFromPoint(point, toPoint: point2, steps: 20)
    }
    
    private func swipeRightToLeft() {
        let x:CGFloat = self.navRootViewController.view.bounds.width - 5
        let y = self.navRootViewController.view.bounds.height / 2
        let point:CGPoint = CGPointMake(x, y);
        
        let xTo:CGFloat = self.navRootViewController.view.bounds.width / 2
        let yTo:CGFloat = 0
        let point2:CGPoint = CGPointMake(xTo, yTo);
        
        self.rootViewController.view.dragFromPoint(point, toPoint: point2, steps: 20)
    }
    
    private func wait(seconds seconds:NSTimeInterval = 1.0) {
        tester.waitForTimeInterval(seconds)
    }
    
    private func clickButton(indentifier: String) {
        self.tester.tapViewWithAccessibilityIdentifier(indentifier)
    }
    
    private func initRootViewController() {
        self.rootViewController = self.listAnimationViewController.presentedViewController as? RootViewController
        let navMainViewController = self.rootViewController.mainViewController as? UINavigationController
        self.mainViewController = navMainViewController?.viewControllers.last as? MainViewController
        
        expect(self.mainViewController).toNot(beNil())
        
        let leftViewController = self.rootViewController.leftViewController as? LeftViewController
        expect(leftViewController).toNot(beNil())
        
        let rightViewController = self.rootViewController.rightViewController as? RightViewController
        expect(rightViewController).toNot(beNil())
    }
    
    private func startViewController() {
        self.navRootViewController = RootViewController.viewControllerWithStoryboard("Main") as! UINavigationController
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = self.navRootViewController
        let _ = self.navRootViewController!.view
        
        self.listAnimationViewController = self.navRootViewController.viewControllers.first as? ListAnimationViewController
        UIApplication.sharedApplication().keyWindow!.makeKeyAndVisible()
    }
}


