//
//  ListViewController.swift
//  Meal Recipes iOS
//
//  Created by Amin faruq on 31/10/22.
//

import UIKit
import Meal_Recipes

public final class ListViewController: UICollectionViewController, UICollectionViewDataSourcePrefetching,  ResourceLoadingView, ResourceErrorView {

    private(set) public var errorView = ErrorView()

    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, CellController> = {
        .init(collectionView: collectionView) { (collectionView, index, controller) in
            controller.dataSource.collectionView(collectionView, cellForItemAt: index)
        }
    }()

    public var onRefresh: (() -> Void)?

    public override func viewDidLoad() {
        configureCollectionView()
        refresh()
    }

    private func configureCollectionView() {
        collectionView.dataSource = dataSource
        errorView.onHide = { [weak self] in
            self?.collectionView.reloadData()
            // self?.collectionView.sizeTableHeaderToFit()
            // self?.collectionView.endUpdates()
        }

    }

    @IBAction private func refresh() {
        onRefresh?()
    }

    public func display(_ sections: [CellController]...) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CellController>()
        sections.enumerated().forEach { section, cellControllers in
            snapshot.appendSections([section])
            snapshot.appendItems(cellControllers, toSection: section)
        }

        if #available(iOS 15.0, *) {
            dataSource.applySnapshotUsingReloadData(snapshot)
        } else {
            dataSource.apply(snapshot)
        }

    }

    public func display(_ viewModel: ResourceLoadingViewModel) {
       
    }

    public func display(_ viewModel: ResourceErrorViewModel) {
        errorView.message = viewModel.message
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dl = cellController(at: indexPath)?.delegate
        dl?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
    
    public override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let dl = cellController(at: indexPath)?.delegate
        dl?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let dl = cellController(at: indexPath)?.delegate
        dl?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            let dsp = cellController(at: indexPath)?.dataSourcePrefetching
            dsp?.collectionView(collectionView, prefetchItemsAt: [indexPath])
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            let dsp = cellController(at: indexPath)?.dataSourcePrefetching
            dsp?.collectionView?(collectionView, cancelPrefetchingForItemsAt: [indexPath])
        }
    }

    private func cellController(at indexPath: IndexPath) -> CellController? {
        dataSource.itemIdentifier(for: indexPath)
    }
}
