//
//  ParallaxHeader.swift
//  ZZParallaxCollection
//
//  Created by 张泽阳 on 5/31/15.
//  Copyright (c) 2015 Zhang Zeyang. All rights reserved.
//

import UIKit
/**
    the Parallax header view,
    which contains the parallaxy image
*/
class ParallaxHeader : UIView
{
    // MARK: - properties
    private var heightConstraints:[AnyObject]?
    private var imageView = UIImageView()
    private var imageContainer = UIView()
    private var paddingX:CGFloat?
    private var paddingY:CGFloat?
    
    /// header view's height, also image container's first height
    var minimumHeight:CGFloat?{
        didSet{
            self.bounds.size.height = minimumHeight!
        }
    }
    /// image container's height
    var height:CGFloat?{
        didSet{
            if height < minimumHeight {height = minimumHeight}
            if let c = heightConstraints {
                self.removeConstraints(c)
            }
            heightConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(diff)-[ic]", options: nil, metrics: ["diff":(minimumHeight! - height!)], views: ["ic":imageContainer])
            self.addConstraints(heightConstraints!)
        }
    }
    
    // MARK: - to make the parallax effect in the axis of x
    func setDX(dx:CGFloat){
        self.frame.origin.x = dx
    }
    
    /**
    setup initial layout
    */
    func doSetup(){
        imageContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.addSubview(imageContainer)
        imageContainer.addSubview(imageView)
        
        imageContainer.backgroundColor = UIColor.blackColor()
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageContainer.clipsToBounds = true
        
        //constraints for container
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[ic]-(0)-|", options: nil, metrics: nil, views: ["ic":imageContainer]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[ic]-(0)-|", options: nil, metrics: nil, views: ["ic":imageContainer]))
        
        // MARK: - constraints for imageView
        // imageView's size constraints
        imageContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(<=0)-[iv]-(<=0)-|", options: nil, metrics: nil, views: ["iv":imageView]))
        imageContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(<=0)-[iv]-(<=0)-|", options: nil, metrics: nil, views: ["iv":imageView]))
        //center XY
        let cX = NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: imageContainer, attribute: .CenterX, multiplier: 1.0, constant: 0)
        cX.priority = 999
        imageContainer.addConstraint(cX)
        let cY = NSLayoutConstraint(item: imageView, attribute: .CenterY, relatedBy: .Equal, toItem: imageContainer, attribute: .CenterY, multiplier: 1.0, constant: 0)
        cY.priority = 1000
        imageContainer.addConstraint(cY)
        
        //aspect ratio
        let iSize = imageView.image!.size
        let cRatio = NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: imageView, attribute: .Width, multiplier: iSize.height / iSize.width, constant: 0)
        imageView.addConstraint(cRatio)
        
        //default W&H
        let widthC = NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: minimumHeight! + paddingX!)
        widthC.priority = 998
        imageView.addConstraint(widthC)
        
        let heightC = NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: minimumHeight! / iSize.height * iSize.width + paddingY!)
        heightC.priority = 997
        imageView.addConstraint(heightC)
        
    }
    
    // MARK: - headerView class contructor
    class func headerView(#imageName:String,fixedHeaderHeight height:CGFloat, paddingSize:CGSize) -> ParallaxHeader{
        var header = ParallaxHeader()
        if let i = UIImage(named: imageName){
            header.imageView.image = i
        }else{
            println("image:\(imageName) not exist!")
        }
        header.minimumHeight = height
        header.paddingX = paddingSize.width
        header.paddingY = paddingSize.height
        header.doSetup()
        return header
    }
}