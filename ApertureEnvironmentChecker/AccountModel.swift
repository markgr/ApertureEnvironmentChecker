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
    var userName : String
    {
        get
        {
            return dictionaryOfObjects!.objectForKey("userName") as String
        }
        set
        {
            dictionaryOfObjects!.setValue(newValue, forKey: "userName");
        }
    }
    
    var fullName : String
    {
        get
        {
            return dictionaryOfObjects!.objectForKey("fullName") as String
        }
        set
        {
            dictionaryOfObjects!.setValue(newValue, forKey: "fullName");
        }
    }
    
    var firstName : String
    {
        get
        {
            return dictionaryOfObjects!.objectForKey("firstName") as String
        }
        set
        {
            dictionaryOfObjects!.setValue(newValue, forKey: "firstName");
        }
    }
    
    var lastName : String
    {
        get
        {
            return dictionaryOfObjects!.objectForKey("lastName") as String
        }
        set
        {
            dictionaryOfObjects!.setValue(newValue, forKey: "lastName");
        }
    }
    
    var emailAddress : String
    {
        get
        {
            return dictionaryOfObjects!.objectForKey("emailAddress") as String
        }
        set
        {
            dictionaryOfObjects!.setValue(newValue, forKey: "emailAddress");
        }
    }
    
    var orgId : String
    {
        get
        {
            return dictionaryOfObjects!.objectForKey("orgId") as String
        }
        set
        {
            dictionaryOfObjects!.setValue(newValue, forKey: "orgId");
        }
    }
    
    override init()
    {
        super.init();
        dictionaryOfObjects = NSMutableDictionary(objectsAndKeys:
                                    "", "userName",
                                    "", "fullName",
                                    "", "firstName",
                                    "", "lastName",
                                    "", "emailAddress",
            "", "orgId");
        isSingleEntry = true;
    }
}