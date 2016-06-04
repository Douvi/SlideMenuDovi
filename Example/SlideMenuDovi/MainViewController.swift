//
//  MainViewController.swift
//  SlideMenuDovi
//
//  Created by Edouard Roussillon on 6/3/16.
//  Copyright © 2016 Edouard Roussillon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //
    // MARK: Click
    //
    
    
    @IBAction func clickClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func clickLeft(sender: AnyObject) {
        self.openSlideMenuLeft()
    }
    
    
    @IBAction func clickRight(sender: AnyObject) {
        self.openSlideMenuRight()
    }
    
}

