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
    
    override func viewWillAppear(animated: Bool)
    {
        SVProgressHUD.showWithStatus("Loading");
        let caas = CaaSCommunicator();
        caas.GetAccountDetails();
        caas.delegate = self;
    }
    
    override func viewDidAppear(animated: Bool)
    {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _collectionView.backgroundColor = UIColor.blackColor();
        
        _collectionView.registerClass(MainLayoutCollectionCellCollectionViewCell.self, forCellWithReuseIdentifier: mainCellIdentifier);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
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
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell:MainLayoutCollectionCellCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(mainCellIdentifier, forIndexPath: indexPath) as MainLayoutCollectionCellCollectionViewCell;
        return cell;
    }
    
//MARK: CaasCommunicatorProtocol functions
    func FinishedParsingAccount(completedObject: AnyObject?)
    {
        if let myAccount:AccountModel? = completedObject as? AccountModel
        {
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
        }
        
        SVProgressHUD.dismiss()
        
        _collectionView.reloadData();
    }
}

