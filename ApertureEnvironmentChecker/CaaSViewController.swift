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
    
    override func viewWillAppear(animated: Bool)
    {
        SVProgressHUD.showWithStatus("Loading");
    }
    
    override func viewDidAppear(animated: Bool)
    {
        let caas = CaaSCommunicator();
        caas.GetAccountDetails();
        caas.delegate = self;
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
        return 10;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 5;
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
            
            let caas = CaaSCommunicator();
            caas.delegate = self;
            caas.GetAllNetworks(organization: myAccount!.orgId)
        }
    }
    
    func FinishedParsingAllNetworks(completedObject: AnyObject?)
    {
        if let myAccount:CaasNetwork? = completedObject as? CaasNetwork
        {
            println("The parsing has finished \(myAccount!)");
            println("The parsing has finished \(myAccount!.ipaddress)");
        }
    }
}

