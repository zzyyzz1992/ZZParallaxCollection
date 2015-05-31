//
//  UnitCollectionViewCell.swift
//  ZZParallaxCollection
//
//  Created by 张泽阳 on 5/31/15.
//  Copyright (c) 2015 Zhang Zeyang. All rights reserved.
//

import UIKit
/**
    Unit Collection View Cell,
    which includes a UnitTableViewController
*/
class UnitCollectionViewCell: UICollectionViewCell {
    // MARK: - properties
    var baseTableViewController:BaseTableViewController? {
        didSet{
            self.addSubview(baseTableViewController!.view)
        }
    }
    
    //tableview type
    var baseTableViewType:BaseTableViewController.Type?
    
    //setup cell
    func setupCell(imageName:String,headerHeight:CGFloat,type:BaseTableViewController.Type,paddingSize:CGSize){
        baseTableViewType = type
        baseTableViewController = baseTableViewType!()
        baseTableViewController?.initHeader(imageName, headerHeight,paddingSize: paddingSize)
        //handle the situation of reusing a cell
        baseTableViewController?.tableView.scrollToRowAtIndexPath(
            NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Bottom, animated: false
        )
    }
    
    // MARK: - to make the parallax effect in the axis of x
    func setDX(dx:CGFloat){
        baseTableViewController?.setDX(dx)
    }
}
