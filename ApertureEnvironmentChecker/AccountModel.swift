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
    
    var fullName = "";
    var firstName = "";
    var lastName = "";
    var emailAddress = "";
    var orgId = "";
    
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