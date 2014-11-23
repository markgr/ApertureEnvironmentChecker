//
//  ViewController.swift
//  ApertureEnvironmentChecker
//
//  Created by Mark Greenwood on 21/11/2014.
//  Copyright (c) 2014 Eviology. All rights reserved.
//

import UIKit

class CaaSViewController: UIViewController
{

    @IBOutlet var _collectionView: UICollectionView!
    
    @IBOutlet var _mainPageLayout: MainPageLayout!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _collectionView.backgroundColor = UIColor.blueColor();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

