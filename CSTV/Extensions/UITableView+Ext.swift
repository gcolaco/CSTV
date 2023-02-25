//
//  UITableView+Ext.swift
//  CSTV-Challenge
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }

}
