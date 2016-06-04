//
//  ListAnimationViewController.swift
//  SlideMenuDovi
//
//  Created by Edouard Roussillon on 6/3/16.
//  Copyright © 2016 Edouard Roussillon. All rights reserved.
//

import UIKit

class ListAnimationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func launchRoot() {
        let root = RootViewController.viewControllerWithStoryboard("Main", controllerName: "RootViewController")
        
        self.navigationController?.presentViewController(root!, animated: true, completion: nil)
    }
    
    //
    // MARK: Click
    //
    
    @IBAction func clickDefault(sender: AnyObject) {
        SliderMenuOptions.animationType = SliderMenuAnimationDefault()
        self.launchRoot()
    }
    
    
    @IBAction func clickSliderOver(sender: AnyObject) {
        SliderMenuOptions.animationType = SliderMenuAnimationSilderOver()
        self.launchRoot()
    }
    
    
}