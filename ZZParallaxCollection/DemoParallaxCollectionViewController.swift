//
//  DemoParallaxCollectionViewController.swift
//  ZZParallaxCollection
//
//  Created by 张泽阳 on 5/31/15.
//  Copyright (c) 2015 Zhang Zeyang. All rights reserved.
//

import UIKit

class DemoParallaxCollectionViewController: BaseParallaxCollectionViewController {
    lazy var pics:[String] = {
        var ps = [String]()
        for i in 1...1 {
            ps += ["\(i).pic"]
        }
        return ps
    }()
    let paddingSize = CGSizeMake(20, 20)
    override func viewDidLoad() {
        super.viewDidLoad()
        velocityFactorOfParallaxScroll = 3.0
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pics.count
    }
    override func getTableViewType(indexPath:NSIndexPath) -> BaseTableViewController.Type {
        return DemoTableViewController.self
    }
    override func setUpCell(unitCell:UnitCollectionViewCell,_ indexPath:NSIndexPath,type:BaseTableViewController.Type){
        unitCell.setupCell(pics[indexPath.row], headerHeight: 300,type: type,paddingSize: paddingSize)
    }
    
}
