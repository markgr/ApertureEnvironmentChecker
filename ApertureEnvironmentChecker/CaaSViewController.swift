//
//  ViewController.swift
//  ApertureEnvironmentChecker
//
//  Created by Mark Greenwood on 21/11/2014.
//  Copyright (c) 2014 Eviology. All rights reserved.
//

import UIKit

let mainCellIdentifier = "MainCell"

class CaaSViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CaasCommunicatorProtocol
{
    @IBOutlet var _collectionView: UICollectionView!
    
    @IBOutlet var _mainPageLayout: MainPageLayout!
    
    var myNetworks:CaaSNetworksModel? = nil;
    var myAccount:AccountModel? = nil;
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBar.hidden = false;
    }
    
    override func viewDidAppear(animated: Bool)
    {
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // _collectionView.backgroundColor = UIColor.whiteColor();
        
        _collectionView.registerClass(MainLayoutCollectionCellCollectionViewCell.self, forCellWithReuseIdentifier: mainCellIdentifier);
        
        self.title = "CaaS Networks";
        
        _collectionView.backgroundColor = UIColor.clearColor();
        
        // Add a gradient to the view
        Utils.addGradientBackground(self.view, layerView: _collectionView);
        
        SVProgressHUD.showWithStatus("Loading");
        let caas = CaaSCommunicator();
        caas.GetAccountDetails();
        caas.delegate = self;
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        if( myNetworks != nil )
        {
            return myNetworks!.arrayOfItems!.count;
        }
        else
        {
            return 0;
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell:MainLayoutCollectionCellCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(mainCellIdentifier, forIndexPath: indexPath) as MainLayoutCollectionCellCollectionViewCell;
        
        if( myNetworks != nil )
        {
            if let network:CaasNetworkModel? = myNetworks!.arrayOfItems!.objectAtIndex(indexPath.section) as? CaasNetworkModel
            {
                cell.setLabel(network!.name)
            }
        }
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        println("Clicked \(indexPath.section) - \(indexPath.row)");
        
        // Create a primary view controller for the main view controller within the storyboard
        if let network:CaasNetworkModel? = myNetworks!.arrayOfItems!.objectAtIndex(indexPath.section) as? CaasNetworkModel
        {
            // First thing to do is to create a new navigation controller!
            let storyBoard = UIStoryboard(name: "Main", bundle: nil);
            
            if let newView = storyBoard.instantiateViewControllerWithIdentifier("CaaSServer") as? CaaSServerController
            {
                newView.orgId = myAccount!.orgId;
                newView.network = network!.id;
                self.navigationController!.pushViewController(newView, animated: true);
            }
        }
    }
    
//MARK: CaasCommunicatorProtocol functions
    func FinishedParsingAccount(completedObject: AnyObject?)
    {
        if let myAccount:AccountModel? = completedObject as? AccountModel
        {
            self.myAccount = myAccount!;
            println("The parsing has finished \(myAccount!)");
            println("The parsing has finished \(myAccount!.fullName)");
            
            SVProgressHUD.showWithStatus("Loading Networks");
            
            let caas = CaaSCommunicator();
            caas.delegate = self;
            caas.GetAllNetworks(organization: myAccount!.orgId)
        }
    }
    
    func FinishedParsingAllNetworks(completedObject: AnyObject?)
    {
        if let myNetworks = completedObject as? CaaSNetworksModel
        {
            println("The parsing has finished \(myNetworks.arrayOfItems!.count)");
            self.myNetworks = myNetworks;
        }
        
        SVProgressHUD.dismiss()
        
        _collectionView.reloadData();
    }
}

