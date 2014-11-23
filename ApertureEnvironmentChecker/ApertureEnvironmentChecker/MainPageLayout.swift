//
//  MainPageLayout.swift
//  ApertureEnvironmentChecker
//
//  Created by Mark Greenwood on 21/11/2014.
//  Copyright (c) 2014 Eviology. All rights reserved.
//

import UIKit

class MainPageLayout: UICollectionViewLayout {
   
    // These are some variables used in the layout
    var itemInserts:UIEdgeInsets = UIEdgeInsets(top: 22.0, left: 22.0, bottom: 13.0, right: 22.0);
    var itemSize:CGSize = CGSize(width: 125.0, height: 125.0);;
    var interItemSpacingY:CGFloat = 12.0;
    var numberOfColumns:NSInteger = 2;
    
    // Static for the type of cell
    let mainLayoutCellKind = "MainLayoutCell";
    
    var layoutDictionary:NSDictionary? = nil;
    
    override init()
    {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func prepareLayout()
    {
        var newLayoutInfo:NSMutableDictionary = NSMutableDictionary();
        var cellLayoutInfo:NSMutableDictionary = NSMutableDictionary();
        
        let sectionCount = self.collectionView?.numberOfSections();
        var indexPath = NSIndexPath(forRow: 0, inSection: 0);
        
        for(var i=0;i < sectionCount ; i++)
        {
            var numItems = self.collectionView?.numberOfItemsInSection(i);
            for(var j=0;j < numItems; j++)
            {
                indexPath = NSIndexPath(forItem: j, inSection: i);
                var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath);
                attributes.frame = self.frameForAlbumPhotoAtIndexPath(indexPath)
                
                cellLayoutInfo[indexPath] = attributes
            }
        }
        
        newLayoutInfo[mainLayoutCellKind] = cellLayoutInfo;
        self.layoutDictionary = newLayoutInfo;
    }
    
    func frameForAlbumPhotoAtIndexPath(indexPath:NSIndexPath) -> CGRect
    {
        let row = indexPath.section / numberOfColumns;
        let column = indexPath.section % numberOfColumns;
        
        let test = CGFloat(numberOfColumns) * itemSize.width;
        var spacingX = CGFloat(self.collectionView!.frame.width) - itemInserts.left - itemInserts.right - test;
        
        if( numberOfColumns > 1 )
        {
            spacingX = CGFloat(spacingX / (CGFloat(numberOfColumns) - 1.0));
        }
        
        let ssX:CGFloat = itemInserts.left + (itemSize.width + spacingX) * CGFloat(column);
        
        let originX = floor(ssX);
        
        let ssY:CGFloat = itemInserts.top + (itemSize.height + interItemSpacingY) * CGFloat(row);
        
        let originY = floor(ssY);
        
        return CGRect(x: originX, y: originY, width: itemSize.width, height: itemSize.height);
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]?
    {
        var allAttributes:NSMutableArray = NSMutableArray(capacity self.layoutDictionary?.count);
        self.layoutDictionary?.enumerateKeysAndObjectsUsingBlock({ (key, obj, stop) -> Void in
            obj.enumerateKeysAndObjectsUsingBlock({ (keyinner, objinner, stopinner) -> Void in
                let innerrect:CGRect? = objinner.CGRectValue()
                if( CGRectIntersectsRect(rect,innerrect!) )
                {
                    allAttributes.addObject(objinner)
                }
            })
        })
        
        return allAttributes;
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        return self.layoutDictionary[indexPath]
    }
    
    override func collectionViewContentSize() -> CGSize
    {
        let rowCount = self.collectionView?.numberOfSections() / numberOfColumns;
        if ( self.collectionView?.numberOfSections() % numberOfColumns)
        {
            rowCount ++;
        }
    }
}
