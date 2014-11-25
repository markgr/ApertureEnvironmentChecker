//
//  Utils.swift
//  ApertureEnvironmentChecker
//
//  Created by Mark Greenwood on 25/11/2014.
//  Copyright (c) 2014 Eviology. All rights reserved.
//

import Foundation

class Utils
{
    class func addGradientBackground(baseview:UIView, layerView:UIView?)
    {
        var arrayOfColors = [];
        let colorTop = UIColor.blackColor().CGColor;
        let colorBottom = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).CGColor;
        arrayOfColors = [colorBottom, colorTop];
        
        let gradientLayer = CAGradientLayer();
        gradientLayer.frame = baseview.frame;
        gradientLayer.colors = arrayOfColors;
        gradientLayer.locations = [0.0,1.0];
        if( layerView != nil )
        {
            baseview.layer.insertSublayer(gradientLayer, below:layerView!.layer);
        }
        else
        {
            baseview.layer.insertSublayer(gradientLayer, atIndex: 0);
        }
    }
}