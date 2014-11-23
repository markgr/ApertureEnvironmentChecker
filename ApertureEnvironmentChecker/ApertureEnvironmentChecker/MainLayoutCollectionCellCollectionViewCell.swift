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
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        self.backgroundColor = UIColor.greenColor();
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}
