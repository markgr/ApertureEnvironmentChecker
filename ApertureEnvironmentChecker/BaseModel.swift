//
//  BaseModel.swift
//  ApertureEnvironmentChecker
//
//  Created by Mark Greenwood on 24/11/2014.
//  Copyright (c) 2014 Eviology. All rights reserved.
//

import UIKit

class BaseModel: NSObject
{
    var arrayOfItems:NSMutableArray? = nil;
    var isSingleEntry = true;
    var outerNode:String = "";
    var encapsulatedClass: AnyClass? = nil;
    
    func AddNewModel() -> Void
    {
        
    }
    
    func GetCurrentModel() -> AnyObject?
    {
        if( arrayOfItems != nil )
        {
            return arrayOfItems![arrayOfItems!.count-1];
        }
        
        return nil;
    }
}
