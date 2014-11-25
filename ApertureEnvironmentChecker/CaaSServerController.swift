//
//  CaaSServerController.swift
//  ApertureEnvironmentChecker
//
//  Created by Mark Greenwood on 25/11/2014.
//  Copyright (c) 2014 Eviology. All rights reserved.
//

import UIKit

class CaaSServerController: UIViewController, UITableViewDataSource, UITableViewDelegate, CaasCommunicatorProtocol
{
    @IBOutlet var _tableView: UITableView!
    
    var servers:CaaSServersModel? = nil;
    let cellIdent:String = "ServerCell";
    var orgId:String? = nil;
    var network:String? = nil;
    
    init(orgGuid:String, network net:String)
    {
        super.init();
        self.orgId = orgGuid;
        self.network = net;
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad()
    {
        self.title = "CaaS Servers";
        
        _tableView.backgroundColor = UIColor.clearColor();
        
        // Add a gradient to the view
        Utils.addGradientBackground(self.view, layerView: _tableView);
        
        _tableView.estimatedRowHeight = 60.0;
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBar.hidden = false;
        
        SVProgressHUD.showWithStatus("Loading Servers");
        
        let caas = CaaSCommunicator();
        caas.delegate = self;
        if (self.orgId != nil && self.network != nil)
        {
            caas.GetAllServerForNetwork(self.orgId!, net: self.network!);
        }
    }
    
    func FinishedParsingAllServers(completedObject: AnyObject?)
    {
        if let myServers = completedObject as? CaaSServersModel
        {
            servers = myServers;
            println("The number of servers in this org are \(myServers.arrayOfItems!.count)")
        }
        
        SVProgressHUD.dismiss();
        
        // Force a reload
        _tableView.reloadData();
        _tableView.contentInset = UIEdgeInsets(top: 35.0, left: 0, bottom: 0, right: 0);
    }
    
    //MARK: Table View stuff
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100.0;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4.0;
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0;
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        var myFooterView = UIView(frame: CGRect(x: 0, y: 0, width: _tableView.bounds.width, height: 4.0));
        myFooterView.backgroundColor = UIColor.clearColor();
        return myFooterView;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        if( servers != nil )
        {
            return servers!.arrayOfItems!.count;
        }
        else
        {
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if( servers != nil )
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    
    func getAttributedText(text:String) -> NSAttributedString
    {
        var attrs = [NSForegroundColorAttributeName: UIColor.whiteColor()];
        var attText = NSMutableAttributedString(string: "\(text)", attributes: attrs);
        var shadow = NSShadow();
        shadow.shadowColor = UIColor.blackColor();
        shadow.shadowOffset = CGSize(width: 0.0, height: 1.0);
        shadow.shadowBlurRadius = 1.0;
        attText.addAttribute(NSShadowAttributeName, value: shadow, range: NSRange(location: 0, length: attText.length));
        
        return attText;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // Now see if we have a resuable cell already
        var cell:  UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdent) as UITableViewCell?;
        if( cell == nil )
        {
            // Ok load in the NIB
            let nib = NSBundle.mainBundle().loadNibNamed("ServerTableViewCell", owner: self, options: nil);
            
            // If the nib count is valid
            if( nib.count > 0 )
            {
                cell = (nib[0] as UITableViewCell);
                
                // Set the background color and stuff...
                cell!.backgroundColor = UIColor.grayColor();
                cell!.layer.borderColor = UIColor.whiteColor().CGColor;
                cell!.layer.borderWidth = 2.0;
                cell!.layer.shadowColor = UIColor.blackColor().CGColor;
                cell!.layer.shadowRadius = 2.0;
                cell!.layer.shadowOffset = CGSize(width: 0.0, height: 2.0);
                cell!.layer.shadowOpacity = 0.5;
                
                cell!.contentView.frame = cell!.bounds;
                cell?.contentView.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleWidth;
            }
        }
        
        // Now do a double check on the cell
        if( cell != nil )
        {
            // Now we can do something with it
            let nameField = cell?.viewWithTag(100) as UILabel;
            let privateIpField = cell?.viewWithTag(101) as UILabel;
            let publicIpField = cell?.viewWithTag(102) as UILabel;
            let specsField = cell?.viewWithTag(103) as UILabel;
            let mnameField = cell?.viewWithTag(104) as UILabel;
            let imageView = cell?.viewWithTag(106) as UIImageView;
            
            if( servers != nil )
            {
                if let server:CaaSServerModel = servers!.arrayOfItems!.objectAtIndex(indexPath.section) as? CaaSServerModel
                {
                    nameField.attributedText = getAttributedText(server.name);
                    privateIpField.attributedText = getAttributedText(server.privateIp);
                    publicIpField.attributedText = getAttributedText(server.publicIp);
                    specsField.attributedText = getAttributedText("\(server.cpuCount) CPU(s) - \(server.memory) MB");
                    mnameField.attributedText = getAttributedText(server.machineName);
                    if( server.isStarted == "true" )
                    {
                        imageView.image = UIImage(named: "tick.png")
                    }
                    else
                    {
                        imageView.image = UIImage(named: "cross.png")
                    }
                }
            }
            
            // Update the normal labels too
            for(var i=200; i < 205; i++)
            {
                if let label:UILabel? = cell!.viewWithTag(i) as? UILabel
                {
                    label!.attributedText = getAttributedText(label!.text!);
                }
            }
        }
        
        return cell!;
    }
}
