//
//  ExpandingTableViewController.swift
//  ExpandingTableView
//
//  Created by Vesza Jozsef on 03/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

/// Default expanding table view controller implementation.
public class ExpandingTableViewController: UITableViewController, ExpandingTableViewControllerType {
    
    /// Index of the currently expanded cell.
    /// Override for custom side effects, when the property is set.
    public var expandedIndexPath: NSIndexPath? {
        didSet {
            switch expandedIndexPath {
            case .Some(let index):
                tableView.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Automatic)
            case .None:
                tableView.reloadRowsAtIndexPaths([oldValue!], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    /// Set the `showDetails` property of the cell based on `expandedIndexPath`.
    /// Subclasses must call this implementation before customizing the cell.
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ExpandingTableViewCell.reuseId) as! ExpandingTableViewCell
        
        switch expandedIndexPath {
        case .Some(let expandedIndexPath) where expandedIndexPath == indexPath:
            cell.showDetails = true
            cell.detailViewHeightConstraint.constant = cell.detailViewHeightConstraintConstant
        default:
            cell.showDetails = false
            cell.detailViewHeightConstraint.constant = 0
        }
        
        return cell
    }
    
    /// Triggers the expansion of the cells.
    /// Subclases may override, but must call super.
    override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        switch expandedIndexPath {
        case .Some(_) where expandedIndexPath == indexPath:
            expandedIndexPath = nil
        case .Some(let expandedIndex) where expandedIndex != indexPath:
            expandedIndexPath = nil
            self.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        default:
            expandedIndexPath = indexPath
        }
    }
    
    
    /// Expands the cell of selected index 
    /// Subclases may override, but must call super.
    override public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        let cell = tableView.dequeueReusableCellWithIdentifier(ExpandingTableViewCell.reuseId) as! ExpandingTableViewCell
        switch expandedIndexPath {
        case .Some(let expandedIndexPath) where expandedIndexPath == indexPath:
            return cell.mainContainerViewHeight.constant + cell.detailViewHeightConstraintConstant
        default:
            cell.showDetails = false
            return cell.mainContainerViewHeight.constant
        }
    }
}
