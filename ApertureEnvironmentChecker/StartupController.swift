//
//  StartupController.swift
//  ApertureEnvironmentChecker
//
//  Created by Mark Greenwood on 24/11/2014.
//  Copyright (c) 2014 Eviology. All rights reserved.
//

import UIKit

class StartupController: UIViewController
{

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBar.hidden = true;
    }
    
    //MARK: UI Events
    @IBAction func CaaSAccountDetails(sender: AnyObject)
    {
        println("Account Details clicked")
        
        // First thing to do is to create a new navigation controller!
        let storyBoard = UIStoryboard(name: "Main", bundle: nil);
        
        // Create a primary view controller for the main view controller within the storyboard
        if let newView = storyBoard.instantiateViewControllerWithIdentifier("CaaSNetworkView") as? CaaSViewController
        {
            self.navigationController?.pushViewController(newView, animated: true);
        }
    }
}
