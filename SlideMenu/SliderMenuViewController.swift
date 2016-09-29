//
//  SliderMenuViewController.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/30/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public protocol SlidingMenuOptionsProtocol : class {
    func setupSlidingMenuOptions()
}

public class SliderMenuViewController: UIViewController, GlobalVariables, SlidingMenuOptionsProtocol {
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public func initPanel(mainViewController: UIViewController, leftMenuViewController: UIViewController) {
        self.initViewController(mainViewController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
    }
    
    public func initPanel(mainViewController: UIViewController, rightMenuViewController: UIViewController) {
        self.initViewController(mainViewController, leftMenuViewController: nil, rightMenuViewController: rightMenuViewController)
    }
    
    public func initPanel(mainViewController: UIViewController, leftMenuViewController: UIViewController, rightMenuViewController: UIViewController) {
        self.initViewController(mainViewController, leftMenuViewController: leftMenuViewController, rightMenuViewController: rightMenuViewController)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge.None
         self.initView()
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.gesture.addLeftPanGestures()
        self.gesture.addRightPanGestures()
    }
    
    public override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.gesture.removeLeftPanGestures()
        self.gesture.removeLeftTapGestures()
        self.gesture.removeRightPanGestures()
        self.gesture.removeRightTapGestures()
    }
   
    public override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        self.animationType.resetAnimationLeftSide()
        self.animationType.resetAnimationRightSide()
        self.animationType.transitionToSize(coordinator)
    }
    
    public func changeMainViewController(mainViewController: UIViewController, close: Bool) {
        self.removeViewController(self.menuViewControllers.mainViewController)
        self.menuViewControllers.mainViewController = mainViewController
        self.setUpViewController(self.menuViews.mainContainerView, targetViewController: mainViewController)
        if close {
            self.closeSlideMenuLeft()
            self.closeSlideMenuRight()
        }
    }
    
    public func changeLeftViewController(leftViewController: UIViewController, close: Bool) {
        self.removeViewController(self.menuViewControllers.leftViewController)
        self.menuViewControllers.leftViewController = leftViewController
        self.setUpViewController(self.menuViews.leftContainerView, targetViewController: leftViewController)
        if close {
            self.closeSlideMenuLeft()
            self.closeSlideMenuRight()
        }
    }
    
    public func changeRightViewController(rightViewController: UIViewController, close: Bool) {
        self.removeViewController(self.menuViewControllers.rightViewController)
        self.menuViewControllers.rightViewController = rightViewController
        self.setUpViewController(self.menuViews.rightContainerView, targetViewController: rightViewController)
        if close {
            self.closeSlideMenuLeft()
            self.closeSlideMenuRight()
        }
    }
    
    //
    // MARK: Toggle Left or Right
    //
    
    public override func toggleSlideMenuLeft() {
        if self.animationType.isLeftSideOpen() {
            self.sendNotification(TrackAction.LeftWillClose)
        } else {
            self.sendNotification(TrackAction.LeftWillOpen)
        }
        self.animationType.toggleLeft()
    }
    
    public override func toggleSlideMenuRight() {
        if self.animationType.isRightSideOpen() {
            self.sendNotification(TrackAction.RightWillClose)
        } else {
            self.sendNotification(TrackAction.RightWillOpen)
        }
        self.animationType.toggleRight()
    }
    
    //
    // MARK: Open Left or Right
    //
    
    public override func openSlideMenuLeft() {
        self.sendNotification(TrackAction.LeftWillOpen)
        self.animationType.openLeft()
    }
    
    public override func openSlideMenuRight() {
        self.sendNotification(TrackAction.RightWillOpen)
        self.animationType.openRight()
    }
    
    //
    // MARK: Close Left or Right
    //
    
    public override func closeSlideMenuLeft() {
        self.sendNotification(TrackAction.LeftWillClose)
        self.animationType.closeLeft()
    }
    
    public override func closeSlideMenuRight() {
        self.sendNotification(TrackAction.RightWillClose)
        self.animationType.closeRight()
    }
    
    //
    // MARK: Check if menu is open
    //
    
    public override func isSlideMenuLeftOpen() -> Bool {
        return self.animationType.isLeftSideOpen()
    }
    
    public override func isSlideMenuRightOpen() -> Bool {
        return self.animationType.isRightSideOpen()
    }
    
    //
    // MARK: Private
    //
    
    private func initViewController(mainViewController: UIViewController, leftMenuViewController: UIViewController?, rightMenuViewController: UIViewController?) {
        self.resetView()
        
        self.menuViewControllers.mainViewController = mainViewController
        self.menuViewControllers.leftViewController = leftMenuViewController
        self.menuViewControllers.rightViewController = rightMenuViewController
        
        self.setUpViewController(self.menuViews.mainContainerView, targetViewController: self.menuViewControllers.mainViewController)
        self.setUpViewController(self.menuViews.leftContainerView, targetViewController: self.menuViewControllers.leftViewController)
        self.setUpViewController(self.menuViews.rightContainerView, targetViewController: self.menuViewControllers.rightViewController)
    }
    
    private func initView() {
        self.menuTools.rootView = self.view
        self.setupSlidingMenuOptions()
        
        self.menuViews.initMainContainerView(view.bounds)
        self.menuViews.initOpacityView(view.bounds)
        self.menuViews.initLeftContainerView(view.bounds)
        self.menuViews.initRightContainerView(view.bounds)
        self.menuViews.initStatusBarView(view.bounds)
        
        self.animationType.orderList()

        self.animationType.resetAnimationLeftSide()
        self.animationType.resetAnimationRightSide()
    }
    
    private func resetView() {
        removeViewController(self.menuViewControllers.mainViewController)
        removeViewController(self.menuViewControllers.leftViewController)
        removeViewController(self.menuViewControllers.rightViewController)
    }
    
    public func setupSlidingMenuOptions() {
        //stub, implementation is subclasses
    }
    
    private func removeViewController(viewController: UIViewController?) {
        if let _viewController = viewController {
            _viewController.willMoveToParentViewController(nil)
            _viewController.view.removeFromSuperview()
            _viewController.removeFromParentViewController()
        }
    }
    
    private func setUpViewController(targetView: UIView, targetViewController: UIViewController?) {
        if let viewController = targetViewController {
            viewController.view.frame = targetView.bounds
            targetView.addSubview(viewController.view)
            viewController.willMoveToParentViewController(self)
            self.addChildViewController(viewController)
            viewController.didMoveToParentViewController(self)
        }
    }
}
