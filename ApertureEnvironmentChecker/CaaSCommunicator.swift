//
//  CaaSCommunicator.swift
//  ApertureEnvironmentChecker
//
//  Created by Mark Greenwood on 24/11/2014.
//  Copyright (c) 2014 Eviology. All rights reserved.
//

import Foundation

class CaaSCommunicator : NSObject, NSXMLParserDelegate
{
    var currentClass:AnyClass? = nil;
    
    func GetAccountDetails() -> AccountModel
    {
        // Setyp the shared client to get the details from the call
        let sharedClient = SVHTTPClient.sharedClient();
        sharedClient.basePath = "https://api-au.dimensiondata.com/oec/0.9/";
        sharedClient.setBasicAuthWithUsername("mark.greenwood", password: "Letme!n1")
        
        var accModel = AccountModel()
        currentClass = object_getClass(accModel);
        
        sharedClient.GET("myaccount", parameters: nil) { (response, httpresponse, error) -> Void in
            println("we got back a \(httpresponse.statusCode)")
            println("the response was \(response) and the class = \(_stdlib_getTypeName(response))")
            if let something:NSData? = response as NSData?
            {
                var xmlParser = NSXMLParser(data: something!);
                xmlParser.delegate = self;
                xmlParser.parse();
            }
        }
    }
    
    /******************************************************
    *
    * Method: parser
    * Returns: Nothing
    * Description: This function is for the XML parsing
    *
    *****************************************************/
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!)
    {
        // Get the properties of the current class
        var count:UInt32 = 0;
        var actualproperties:UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(currentClass, &count);
        println("count of properties = \(count)");
        
        println("Elements' Name = \(elementName)")
        
        // Check each property and see if this matches
        for var i = 0; i < Int(count); i++
        {
            var property = actualproperties[i];
            var propertyName = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding);
            if( propertyName! == elementName! )
            {
                // Set this property!
                currentClass!.setValue(value: "Test", forKey: propertyName)
            }
        }
    }
}

