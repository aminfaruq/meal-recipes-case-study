//
//  CategoriesAdapter.swift
//  Meal Recipes App
//
//  Created by Amin faruq on 01/11/22.
//

import UIKit
import Meal_Recipes
import Meal_Recipes_iOS

final class CategoriesAdapter : ResourceView{
    private weak var controller: ListViewController?
    private let imageLoader: (URL) -> CategoryImageDataLoader.Publisher
    private typealias ImageDataPresentationAdapter = LoadResourcePresentationAdapter<Data, WeakRefVirtualProxy<CategoryCellController>>
    private let currentCategory: [CategoryViewModel: CellController]

    init(currentCategory: [CategoryViewModel: CellController] = [:], controller: ListViewController, imageLoader: @escaping (URL) -> CategoryImageDataLoader.Publisher) {
        self.currentCategory = currentCategory
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    
    func display(_ viewModel: CategoriesViewModel) {
        guard let controller = controller else { return }
        
        var currentCategory = self.currentCategory
        
        let feed: [CellController] = viewModel.categories.map { model in
            if let controller = currentCategory[model] {
                return controller
            }
            
            let adapter = ImageDataPresentationAdapter(loader: { [imageLoader] in
                imageLoader(model.strCategoryThumb)
            })
            
            let view = CategoryCellController(
                viewModel: model,
                delegate: adapter,
                selection: {
                    
                })
            
            adapter.presenter = LoadResourcePresenter(
                resourceView: WeakRefVirtualProxy(view),
                loadingView: WeakRefVirtualProxy(view),
                errorView: WeakRefVirtualProxy(view),
                mapper: UIImage.tryMake )
            
            let controller = CellController(id: model, view)
            currentCategory[model] = controller
            return controller
        }
        
        controller.display(feed)

    }
}

extension UIImage {
    struct InvalidImageData: Error {}
    
    static func tryMake(data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw InvalidImageData()
        }
        return image
    }
}
