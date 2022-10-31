//
//  UIRefreshControl+Helpers.swift
//  Meal Recipes iOS
//
//  Created by Amin faruq on 31/10/22.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
