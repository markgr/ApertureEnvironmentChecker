//
//  CaaSServersModel.swift
//  ApertureEnvironmentChecker
//
//  Created by Mark Greenwood on 25/11/2014.
//  Copyright (c) 2014 Eviology. All rights reserved.
//

import Foundation

class CaaSServersModel : BaseModel
{
    override init()
    {
        super.init();
        self.isSingleEntry = false;
        self.outerNode = "server";
        self.encapsulatedClass = CaaSServerModel.self;
    }
    
    override func AddNewModel() -> Void
    {
        if( arrayOfItems == nil )
        {
            arrayOfItems = NSMutableArray();
        }
        
        let caasObject:CaaSServerModel = CaaSServerModel();
        arrayOfItems?.addObject(caasObject);
    }
}