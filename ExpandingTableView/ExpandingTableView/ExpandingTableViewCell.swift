//
//  ExpandingTableViewCell.swift
//  ExpandingTableView
//
//  Created by Vesza Jozsef on 03/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

/// Default implementation of an expanding table view cell.
public class ExpandingTableViewCell: UITableViewCell, ExpandingCellType {
    
    private let lowLayoutPriority: Float = 250
    private let highLayoutPriority: Float = 999
    
    // Height of detail view
    public var detailViewHeightConstraintConstant: CGFloat = 0
    
    /// Reuse identifier for the given class. 
    /// Override for custom id.
    public static var reuseId = "ExpandingCell"
    
    /// Primary view in the cell. Be sure to connect the outlet.
    @IBOutlet public weak var mainContainerView: UIView!
    /// Expandable detail view in the cell. Be sure to connect the outlet.
    @IBOutlet public weak var detailContainerView: UIView!
    
    /// The height of the detail view. Be sure to connect the outlet.
    @IBOutlet public weak var detailViewHeightConstraint: NSLayoutConstraint!
    
    /// The height of the main view. Be sure to connect the outlet.
    @IBOutlet public weak var mainContainerViewHeight: NSLayoutConstraint!
    
    /// Control whether the details view is shown or not. 
    /// Override for custom behavior.
    public var showDetails = false {
        didSet {
            detailViewHeightConstraint.priority = showDetails ? lowLayoutPriority : highLayoutPriority
        }
    }
    
    /// Hide the detail view initially.
    override public func awakeFromNib() {
        super.awakeFromNib()
        detailViewHeightConstraintConstant = detailViewHeightConstraint.constant
        detailViewHeightConstraint.constant = 0
    }
}
