//
//  RootViewController.swift
//  SlideMenuDovi
//
//  Created by Edouard Roussillon on 6/3/16.
//  Copyright © 2016 Edouard Roussillon. All rights reserved.
//

import UIKit

class RootViewController: SliderMenuViewController {
    
    static internal func viewControllerWithStoryboard(storyboardName: String!, controllerName: String = "") -> UIViewController? {
        let mainStoryboard: UIStoryboard? = UIStoryboard(name: storyboardName,  bundle: nil)
            
        if controllerName != "" {
            return mainStoryboard?.instantiateViewControllerWithIdentifier(controllerName)
        } else {
            return mainStoryboard?.instantiateInitialViewController()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let main = RootViewController.viewControllerWithStoryboard("Main", controllerName: "navMainViewController")
        let left = RootViewController.viewControllerWithStoryboard("Main", controllerName: "LeftViewController")
        let right = RootViewController.viewControllerWithStoryboard("Main", controllerName: "RightViewController")
        
        self.initPanel(main!, leftMenuViewController: left!, rightMenuViewController: right!)
    }
    
}