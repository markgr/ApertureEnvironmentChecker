//
//  CaaSNetworksModel.swift
//  ApertureEnvironmentChecker
//
//  Created by Mark Greenwood on 24/11/2014.
//  Copyright (c) 2014 Eviology. All rights reserved.
//

import Foundation

class CaaSNetworksModel : BaseModel
{
    override init()
    {
        super.init();
        self.isSingleEntry = false;
        self.outerNode = "network";
        self.encapsulatedClass = CaasNetworkModel.self;
    }
    
    override func AddNewModel() -> Void
    {
        if( arrayOfItems == nil )
        {
            arrayOfItems = NSMutableArray();
        }
        
        let casObject:CaasNetworkModel = CaasNetworkModel();
        arrayOfItems?.addObject(casObject);
    }
}