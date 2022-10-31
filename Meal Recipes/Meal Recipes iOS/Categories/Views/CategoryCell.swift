//
//  CategoryCell.swift
//  Meal Recipes iOS
//
//  Created by Amin faruq on 31/10/22.
//

import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet private(set) public var categoryNameLabel: UILabel!
    @IBOutlet private(set) public var categoryDescriptionLabel: UILabel!
    @IBOutlet private(set) public var categoryImage: UIImageView!
    @IBOutlet private(set) public var categoryRetryButton: UIButton!
    @IBOutlet private(set) public var categoryImageContainer: UIView!

    var onRetry: (() -> Void)?

    @IBAction private func retryButtonTapped() {
        onRetry?()
    }
}
