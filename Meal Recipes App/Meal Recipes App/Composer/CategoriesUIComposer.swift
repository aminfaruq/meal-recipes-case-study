//
//  CategoriesUIComposer.swift
//  Meal Recipes App
//
//  Created by Amin faruq on 01/11/22.
//

import UIKit
import Combine
import Meal_Recipes
import Meal_Recipes_iOS

public final class CategoriesUIComposer {
    private init() {}
    
    private typealias FeedPresentationAdapter = LoadResourcePresentationAdapter<[RemoteCategory], CategoriesAdapter>
    
    
    public static func categoryComposedWith(
        categoryLoader: @escaping () -> AnyPublisher<[RemoteCategory], Error>,
        imageLoader: @escaping (URL) -> CategoryImageDataLoader.Publisher
    ) -> ListViewController {
        let presentationAdapter = FeedPresentationAdapter(loader: {  categoryLoader().dispatchOnMainQueue() })
        let categoryController = makeCategoryViewController()
        categoryController.onRefresh = presentationAdapter.loadResource
        
        presentationAdapter.presenter = LoadResourcePresenter(
            resourceView: CategoriesAdapter(
                controller: categoryController,
                imageLoader: imageLoader),
            loadingView: WeakRefVirtualProxy(categoryController),
            errorView: WeakRefVirtualProxy(categoryController),
            mapper: { CategoriesPresenter.map($0) } )
        
        return categoryController
        
    }
    
    private static func makeCategoryViewController() -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "Category", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! ListViewController
//        feedController.title = FeedPresenter.title
        return feedController
    }
}
