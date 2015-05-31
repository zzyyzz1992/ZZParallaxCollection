//
//  DemoTableViewController.swift
//  ZZParallaxCollection
//
//  Created by 张泽阳 on 5/31/15.
//  Copyright (c) 2015 Zhang Zeyang. All rights reserved.
//

import UIKit

class DemoTableViewController: BaseTableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "id")
        cell.textLabel?.text = "item\(indexPath.row)"
        return cell
    }
}
