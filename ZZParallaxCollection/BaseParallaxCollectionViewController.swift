//
//  BaseParallaxCollectionViewController.swift
//  ZZParallaxCollection
//
//  Created by 张泽阳 on 5/31/15.
//  Copyright (c) 2015 Zhang Zeyang. All rights reserved.
//

import UIKit
/**
    the base class of ParallaxCollectionViewController,
    which consists of a collectionView scrolls horizontally
*/
class BaseParallaxCollectionViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    // MARK: - properties
    private lazy var cellBounds = UIScreen.mainScreen().bounds
    /// the velocity factor of ParallaxScroll, must greater than 1.0
    var velocityFactorOfParallaxScroll:CGFloat = 2.5
    /// collectionView scrolls horizontally
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = self.cellBounds.size
        let v = UICollectionView(frame:self.cellBounds, collectionViewLayout: layout)
        v.backgroundColor = UIColor.brownColor()
        v.registerClass(UnitCollectionViewCell.self, forCellWithReuseIdentifier:"unit_para_cell")
        v.showsHorizontalScrollIndicator = false
        v.pagingEnabled = true
        self.view.addSubview(v)
        return v
        }()
    
    // MARK: -
    /// set delegate & dataSource
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - delegate methods
    /// handle the scroll event,to make the parallax effect in the axis of x
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let dx = scrollView.contentOffset.x
        let width = cellBounds.size.width
        for cell in collectionView.visibleCells() as! [UnitCollectionViewCell] {
            let idx = collectionView.indexPathForCell(cell)!
            let offset:CGFloat = width * CGFloat(idx.row)
            let diff = (dx - offset)
            cell.setDX(diff/velocityFactorOfParallaxScroll)
        }
    }
    
    /// delegate method to generate collection cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let unitCell:UnitCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("unit_para_cell", forIndexPath: indexPath) as! UnitCollectionViewCell
        setUpCell(unitCell, indexPath,type: getTableViewType(indexPath))
        return unitCell
    }
    
    // MARK: - ---------------method need to be overridden---------------
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        assertionFailure("need override\(__FUNCTION__)")
        return 0
    }
    
    func setUpCell(unitCell:UnitCollectionViewCell,_ indexPath:NSIndexPath,type:BaseTableViewController.Type){
        assertionFailure("need override\(__FUNCTION__)")
    }
    
    func getTableViewType(indexPath:NSIndexPath) -> BaseTableViewController.Type {
        assertionFailure("need override\(__FUNCTION__)")
        return BaseTableViewController.self
    }
    // MARK: -
    
    
    /**
    make status bar hidden
    */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
