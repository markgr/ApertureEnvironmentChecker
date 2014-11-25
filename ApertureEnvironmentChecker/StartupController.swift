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
    override func viewDidLoad() {
        Utils.addGradientBackground(self.view, layerView: nil);
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBar.hidden = true;
    }
    
    @IBAction func CsfmCaaSDetailsClciked(sender: AnyObject)
    {
        // Read in the plist (if we can)
        let path = NSBundle.mainBundle().pathForResource("CsfmServerList", ofType: "plist");
        let array = NSArray(contentsOfFile: path!);
        
        println("number of servers = \(array?.count)");
        
        // First thing to do is to create a new navigation controller!
        let storyBoard = UIStoryboard(name: "Main", bundle: nil);
        
        if let newView = storyBoard.instantiateViewControllerWithIdentifier("CaaSServer") as? CaaSServerController
        {
            newView.plistFile = array!;
            self.navigationController?.pushViewController(newView, animated: true);
        }
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
