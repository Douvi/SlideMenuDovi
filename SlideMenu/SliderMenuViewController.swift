//
//  SliderMenuViewController.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/30/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public class SliderMenuViewController: UIViewController, GlobalVariables {
    
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
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.gesture.addLeftPanGestures()
        self.gesture.addRightPanGestures()
    }
    
    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.gesture.removeLeftPanGestures()
        self.gesture.removeLeftTapGestures()
        self.gesture.removeRightPanGestures()
        self.gesture.removeRightTapGestures()
    }

    public override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
        
        self.setUpViewController(self.menuViews.mainContainerView, targetViewController: self.menuViewControllers.mainViewController)
        self.setUpViewController(self.menuViews.leftContainerView, targetViewController: self.menuViewControllers.leftViewController)
        self.setUpViewController(self.menuViews.rightContainerView, targetViewController: self.menuViewControllers.rightViewController)
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
    
    private func removeViewController(viewController: UIViewController?) {
        if let _viewController = viewController {
            _viewController.willMoveToParentViewController(nil)
            _viewController.view.removeFromSuperview()
            _viewController.removeFromParentViewController()
        }
    }
    
    //
    // MARK: Toggle Left or Right
    //
    
    public override func toggleSlideMenuLeft() {
        self.animationType.toggleLeft()
    }
    
    public override func toggleSlideMenuRight() {
        self.animationType.toggleRight()
    }
    
    //
    // MARK: Open Left or Right
    //
    
    public override func openSlideMenuLeft() {
       self.animationType.openLeft()
    }
    
    public override func openSlideMenuRight() {
        self.animationType.openRight()
    }
    
    //
    // MARK: Close Left or Right
    //
    
    public override func closeSlideMenuLeft() {
        self.animationType.closeLeft()
    }
    
    public override func closeSlideMenuRight() {
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
    // MARK: TO be override
    //
//    
//    public func track(trackAction: TrackAction) {
//        // function is for tracking
//        // Please to override it if necessary
//    }
    
    //
    // MARK: Private
    //
    
    private func initViewController(mainViewController: UIViewController, leftMenuViewController: UIViewController?, rightMenuViewController: UIViewController?) {
        self.menuViewControllers.mainViewController = mainViewController
        self.menuViewControllers.leftViewController = leftMenuViewController
        self.menuViewControllers.rightViewController = rightMenuViewController
        self.initView()
    }
    
    private func initView() {
        self.menuTools.rootView = self.view
        
        self.menuViews.initMainContainerView(view.bounds)
        self.menuViews.initOpacityView(view.bounds)
        self.menuViews.initLeftContainerView(view.bounds)
        self.menuViews.initRightContainerView(view.bounds)
        self.menuViews.initStatusBarView(view.bounds)
        
        self.animationType.orderList()

        self.animationType.resetAnimationLeftSide()
        self.animationType.resetAnimationRightSide()
    }
    
    private func setUpViewController(targetView: UIView, targetViewController: UIViewController?) {
        if let viewController = targetViewController {
            addChildViewController(viewController)
            viewController.view.frame = targetView.bounds
            targetView.addSubview(viewController.view)
            viewController.didMoveToParentViewController(self)
        }
    }
}