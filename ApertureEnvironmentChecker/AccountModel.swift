//
//  AccountModel.swift
//  ApertureEnvironmentChecker
//
//  Created by Mark Greenwood on 24/11/2014.
//  Copyright (c) 2014 Eviology. All rights reserved.
//

import Foundation

class AccountModel : BaseModel
{
    var innerDictionary : NSMutableDictionary?
    {
        get
        {
            if( arrayOfItems != nil )
            {
                return arrayOfItems![0] as? NSMutableDictionary;
            }
            
            return nil;
        }
    }
    
    var userName : String
    {
        get
        {
            return innerDictionary!.objectForKey("userName") as String
        }
        set
        {
            innerDictionary!.setValue(newValue, forKey: "userName");
        }
    }
    
    var fullName : String
    {
        get
        {
            return innerDictionary!.objectForKey("fullName") as String
        }
        set
        {
            innerDictionary!.setValue(newValue, forKey: "fullName");
        }
    }
    
    var firstName : String
    {
        get
        {
            return innerDictionary!.objectForKey("firstName") as String
        }
        set
        {
            innerDictionary!.setValue(newValue, forKey: "firstName");
        }
    }
    
    var lastName : String
    {
        get
        {
            return innerDictionary!.objectForKey("lastName") as String
        }
        set
        {
            innerDictionary!.setValue(newValue, forKey: "lastName");
        }
    }
    
    var emailAddress : String
    {
        get
        {
            return innerDictionary!.objectForKey("emailAddress") as String
        }
        set
        {
            innerDictionary!.setValue(newValue, forKey: "emailAddress");
        }
    }
    
    var orgId : String
    {
        get
        {
            return innerDictionary!.objectForKey("orgId") as String
        }
        set
        {
            innerDictionary!.setValue(newValue, forKey: "orgId");
        }
    }
    
    override init()
    {
        super.init();
        let dictionaryOfObjects:NSMutableDictionary = NSMutableDictionary(objectsAndKeys:
                                    "", "userName",
                                    "", "fullName",
                                    "", "firstName",
                                    "", "lastName",
                                    "", "emailAddress",
                                    "", "orgId");
        arrayOfItems = NSMutableArray(object: dictionaryOfObjects);
        
        isSingleEntry = true;
    }
}