//
//  ExpandingTableViewController.swift
//  ExpandingTableView
//
//  Created by Vesza Jozsef on 03/06/15.
//  Updated by Alvin Tabontabon and Edmilyn Domingo 08/24/16
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

/// Default expanding table view controller implementation.
public class ExpandingTableViewController: UITableViewController {
    
    /// List of Indexes of the currently expanded cell.
    private var selectedIndices = [NSIndexPath]()
    
    func addSelectedIndex(newVal: NSIndexPath) {
        selectedIndices.append(newVal)
        tableView.reloadRowsAtIndexPaths(selectedIndices, withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    /// Check if Index already Exist
    func isIndexAlreadyExist(item: NSIndexPath) -> Int? {
        var ctr = 0
        for index in selectedIndices {
            if index.row == item.row {
                return ctr
            }
            ctr += 1
        }
        return nil
    }
    
    /// Remove selected index
    func removeSelectedIndex(val: NSIndexPath) {
        let index = isIndexAlreadyExist(val)
        
        if index != nil {
            selectedIndices.removeAtIndex(index!)
        }
        tableView.reloadRowsAtIndexPaths([val], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    // MARK - END
    
    /// Set the `showDetails` property of the cell based on `expandedIndexPath`.
    /// Subclasses must call this implementation before customizing the cell.
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ExpandingTableViewCell.reuseId) as! ExpandingTableViewCell
        
        if selectedIndices.isEmpty {
            cell.showDetails = false
            cell.detailViewHeightConstraint.constant = 0
            
        } else {
            
            if (isIndexAlreadyExist(indexPath) != nil) {
                cell.showDetails = true
                cell.detailViewHeightConstraint.constant = cell.detailViewHeightConstraintConstant
            } else {
                cell.showDetails = false
                cell.detailViewHeightConstraint.constant = 0
            }
        }
        return cell
    }
    
    /// Triggers the expansion of the cells.
    /// Subclases may override, but must call super.
    override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if (isIndexAlreadyExist(indexPath) != nil) {
            removeSelectedIndex(indexPath)
        } else {
            addSelectedIndex(indexPath)
        }
    }
    
    
    /// Expands the cell of selected index
    /// Subclases may override, but must call super.
    override public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        let cell = tableView.dequeueReusableCellWithIdentifier(ExpandingTableViewCell.reuseId) as! ExpandingTableViewCell
        if selectedIndices.isEmpty {
            cell.showDetails = false
            return cell.mainContainerViewHeight.constant
        } else {
            if (isIndexAlreadyExist(indexPath) != nil) {
                return cell.mainContainerViewHeight.constant + cell.detailViewHeightConstraintConstant
            } else {
                cell.showDetails = false
                return cell.mainContainerViewHeight.constant
            }
        }
        
    }
}
