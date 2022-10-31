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

extension CategoryCellController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 1 }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cell =  collectionView.dequeueReusableCell(indexPath: indexPath)
        cell?.categoryNameLabel.text = viewModel.strCategory
        cell?.categoryImage.image = nil
        cell?.onRetry = { [weak self] in
            self?.delegate.didRequestImage()
        }
        return cell!
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selection()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cancelLoad()
    }
    
    public func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        delegate.didRequestImage()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
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
        //MARK: - DO MORE
    }
    
    public func display(_ viewModel: ResourceErrorViewModel) {
        cell?.categoryRetryButton.isHidden = viewModel.message == nil
    }
    
    
}
