//
//  CategoryCellController.swift
//  Meal Recipes iOS
//
//  Created by Amin faruq on 31/10/22.
//

import UIKit
import Meal_Recipes

public protocol CategoryCellControllerDelegate {
    func didRequestImage()
    func didCancelImageRequest()
}


public class CategoryCellController: NSObject {
    public typealias ResourceViewModel = UIImage
    
    private let viewModel: CategoryViewModel
    private let delegate: CategoryCellControllerDelegate
    private let selection: () -> Void
    private var cell: CategoryCell?
    
    
    public init(viewModel: CategoryViewModel, delegate: CategoryCellControllerDelegate, selection: @escaping () -> Void) {
        self.viewModel = viewModel
        self.delegate = delegate
        self.selection = selection
    }
}

extension CategoryCellController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching  {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        cell?.categoryNameLabel.text = viewModel.strCategory
        cell?.categoryDescriptionLabel.text = viewModel.strCategoryDescription
        cell?.categoryImage.image = nil
        cell?.onRetry = { [weak self] in
            self?.delegate.didRequestImage()
        }
        delegate.didRequestImage()
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection()
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelLoad()
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        delegate.didRequestImage()
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        cancelLoad()
    }
    
    private func cancelLoad() {
        releaseCellForReuse()
        delegate.didCancelImageRequest()
    }
    
    private func releaseCellForReuse() {
        cell = nil
    }
}

extension CategoryCellController: ResourceView, ResourceLoadingView, ResourceErrorView {
    public func display(_ viewModel: UIImage) {
        cell?.categoryImage.setImageAnimated(viewModel)
    }
    
    public func display(_ viewModel: ResourceLoadingViewModel) {
        cell?.categoryImageContainer.isShimmering = viewModel.isLoading
    }
    
    public func display(_ viewModel: ResourceErrorViewModel) {
        cell?.categoryRetryButton.isHidden = viewModel.message == nil
    }
    
}
