//
//  TableViewModel.swift
//  ExpandableTableView
//
//  Created by Vesza Jozsef on 06/05/15.
//  Copyright (c) 2015 Vesza Jozsef. All rights reserved.
//

import UIKit
import ViewModelExtensions

struct TableViewModel: ViewModelType {
    
    let photoStore: PhotoStore
    
    init(photoStore: PhotoStore) {
        self.photoStore = photoStore
    }
    
    var count: Int {
        return photoStore.photos.count
    }
    
    func photoForRow(row: Int) -> Photo {
        return photoStore.photos[row]
    }
    
    func titleForRow(row: Int) -> String {
        return photoStore.photos[row].title
    }
}