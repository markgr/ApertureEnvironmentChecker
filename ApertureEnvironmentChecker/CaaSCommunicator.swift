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
    var anyObject:AnyObject? = nil;
    var delegate:CaasCommunicatorProtocol? = nil;
    var currentXmlElement:String? = nil;
    
    func GetAccountDetails() -> Void
    {
        // Setyp the shared client to get the details from the call
        let sharedClient = SVHTTPClient.sharedClient();
        sharedClient.basePath = "https://api-au.dimensiondata.com/oec/0.9/";
        sharedClient.setBasicAuthWithUsername("mark.greenwood", password: "Letme!n1")
        
        var accModel = AccountModel()
        currentClass = object_getClass(accModel);
        anyObject = accModel;
        
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
    
    func GetAllNetworks(organization orgId:String) -> Void
    {
        // Setyp the shared client to get the details from the call
        let sharedClient = SVHTTPClient.sharedClient();
        sharedClient.basePath = "https://api-au.dimensiondata.com/oec/0.9/";
        sharedClient.setBasicAuthWithUsername("mark.greenwood", password: "Letme!n1")
        
        var accModel = CaaSNetworksModel()
        currentClass = object_getClass(accModel);
        anyObject = accModel;
        
        sharedClient.GET(orgId + "/networkWithLocation", parameters: nil) { (response, httpresponse, error) -> Void in
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
    
    func stripColonsFromElement(element:String) -> String
    {
        if( NSString(string: element).containsString(":") )
        {
            let characterToFind : Character = ":";
            if let characterIndex = find(element, characterToFind)
            {
                let newString = element.substringFromIndex(characterIndex.successor())
                return newString;
            }
        }
        
        return element;
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
        println("Elements' Name = \(stripColonsFromElement(elementName)) namespaceUri = \(namespaceURI), qualifiedName = \(qName)")
        
        var elementrealName = stripColonsFromElement(elementName);
        
        currentXmlElement = elementrealName;
        
        // Check if the class is a multi level entry - then we need to check the element itself
        if( anyObject is BaseModel )
        {
            // And its a multi level one
            if let baseModelClass:BaseModel? = anyObject as? BaseModel
            {
                if( baseModelClass!.isSingleEntry == false )
                {
                    // Now check the outer node
                    if( baseModelClass!.outerNode == currentXmlElement )
                    {
                        // Create a new entry in the base model class now
                        baseModelClass!.AddNewModel();
                    }
                }
            }
        }
    }
    
    func singleModelParser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        var count:UInt32 = 0;
        var actualproperties:UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(currentClass, &count);
        println("count of properties = \(count)");
        
        // Check each property and see if this matches
        for var i = 0; i < Int(count); i++
        {
            var property = actualproperties[i];
            var propertyName = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding);
            
            if( propertyName! == currentXmlElement )
            {
                // Set this property!
                if var currentString: String? = self.anyObject?.valueForKey(propertyName!) as? String
                {
                    var newString = currentString! + string;
                    newString = newString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
                    self.anyObject?.setValue(newString, forKey: propertyName!);
                    
                    println("setting \(propertyName) with \(newString)")
                }
            }
        }
    }
    
    func multiModelParser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        if let baseModelClass:BaseModel? = anyObject as? BaseModel
        {
            var count:UInt32 = 0;
            var actualproperties:UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(baseModelClass!.encapsulatedClass, &count);
            println("count of properties = \(count)");
            
            // Check each property and see if this matches
            for var i = 0; i < Int(count); i++
            {
                var property = actualproperties[i];
                var propertyName = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding);
                
                if( propertyName! == currentXmlElement )
                {
                    // Set this property!
                    if var currentString: String? = baseModelClass!.GetCurrentModel()!.valueForKey(propertyName!) as? String
                    {
                        var newString = currentString! + string;
                        newString = newString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
                        baseModelClass!.GetCurrentModel()!.setValue(newString, forKey: propertyName!);
                        
                        println("setting \(propertyName) with \(newString)")
                    }
                }
            }
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        if( anyObject is BaseModel )
        {
            // And its a multi level one
            if let baseModelClass:BaseModel? = anyObject as? BaseModel
            {
                if( baseModelClass!.isSingleEntry == true )
                {
                    self.singleModelParser(parser, foundCharacters: string);
                }
                else
                {   self.multiModelParser(parser, foundCharacters: string)
                    
                }
            }
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser!)
    {
        // Make sure we have a delegate
        if( delegate != nil )
        {
            if (anyObject is AccountModel)
            {
                delegate!.FinishedParsingAccount(self.anyObject?);
            }
            else if ( anyObject is CaaSNetworksModel )
            {
                delegate!.FinishedParsingAllNetworks(self.anyObject?);
            }
        }
    }
}

protocol CaasCommunicatorProtocol
{
    func FinishedParsingAccount(completedObject:AnyObject?);
    func FinishedParsingAllNetworks(completedObject:AnyObject?);
}

