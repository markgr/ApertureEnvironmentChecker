//
//  MainLayoutCollectionCellCollectionViewCell.swift
//  ApertureEnvironmentChecker
//
//  Created by Mark Greenwood on 21/11/2014.
//  Copyright (c) 2014 Eviology. All rights reserved.
//

import UIKit

class MainLayoutCollectionCellCollectionViewCell: UICollectionViewCell
{
    var computerNumber:UILabel? = nil;
    
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        
        self.backgroundColor = UIColor.grayColor();
        
        // Setup the look and feel
        self.layer.borderColor = UIColor.whiteColor().CGColor;
        self.layer.borderWidth = 2.0;
        self.layer.shadowColor = UIColor.blackColor().CGColor;
        self.layer.shadowRadius = 2.0;
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0);
        self.layer.shadowOpacity = 0.5;
        
        // Create the label for the number of computers
        let labelFrame = CGRect(x: 5, y: (frame.size.height / 2.0) / 2.0, width: frame.width - 10.0, height: frame.height / 2.0);
        computerNumber = UILabel(frame: labelFrame);
        computerNumber!.font = UIFont.systemFontOfSize(10.0);
        computerNumber!.textAlignment = NSTextAlignment.Center;
        
        self.contentView.addSubview(computerNumber!);
    }
    
    func setLabel(labelDetails:String)
    {
        if( computerNumber != nil )
        {
            var attrs = [NSForegroundColorAttributeName: UIColor.whiteColor()];
            var attText = NSMutableAttributedString(string: "\(labelDetails)", attributes: attrs);
            var shadow = NSShadow();
            shadow.shadowColor = UIColor.blackColor();
            shadow.shadowOffset = CGSize(width: 0.0, height: 1.0);
            shadow.shadowBlurRadius = 1.0;
            attText.addAttribute(NSShadowAttributeName, value: shadow, range: NSRange(location: 0, length: attText.length));
            
            computerNumber?.attributedText = attText;
        }
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse()
    {
        // Make sure we set up as normal
        super.prepareForReuse()
        
        // We can also do something here as well if need be....
    }
}
