//
//  BaseTableViewController.swift
//  ZZParallaxCollection
//
//  Created by 张泽阳 on 5/31/15.
//  Copyright (c) 2015 Zhang Zeyang. All rights reserved.
//

import UIKit
class BaseTableViewController: UITableViewController {
    // MARK: - to make the parallax effect in the axis of x
    func setDX(dx:CGFloat){
        let hv = tableView.tableHeaderView as! ParallaxHeader
        hv.setDX(dx)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        var  scrollOffset:CGFloat = scrollView.contentOffset.y;
        //        println(scrollOffset)
        let hv = tableView.tableHeaderView as! ParallaxHeader
        if (scrollOffset < 0) {
            hv.height = hv.minimumHeight! - scrollOffset;
        } else {
            hv.height = hv.minimumHeight!
        }
        hv.setNeedsUpdateConstraints()
    }
    
    func initHeader(name:String,_ headerHeight:CGFloat,paddingSize:CGSize){
        tableView.tableHeaderView = ParallaxHeader.headerView(imageName: name, fixedHeaderHeight: headerHeight,paddingSize: paddingSize)
        tableView.tableHeaderView?.backgroundColor = UIColor.cyanColor()
        scrollViewDidScroll(tableView)
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        assertionFailure("need override\(__FUNCTION__)")
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        assertionFailure("need override\(__FUNCTION__)")
        return 20
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        assertionFailure("need override\(__FUNCTION__)")
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "id")
        cell.textLabel?.text = "item\(indexPath.row)"
        return cell
    }
    // MARK: -
}
