//
//  CategorySnapshotTest.swift
//  Meal Recipes iOSTests
//
//  Created by Amin faruq on 31/10/22.
//

import XCTest
import Meal_Recipes_iOS
@testable import Meal_Recipes

class CategorySnapshotTest: XCTestCase {
    
    func test_feedWithContent() {
        let sut = makeSUT()
        
        sut.display(feedWithContent())
        
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "CATEGORIES_WITH_CONTENT_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)), named: "CATEGORIES_WITH_CONTENT_dark")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "CATEGORIES_WITH_CONTENT_light_extraExtraExtraLarge")
    }
    
    func test_feedWithFailedImageLoading() {
        let sut = makeSUT()
        
        sut.display(feedWithFailedImageLoading())
        
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "CATEGORIES_WITH_FAILED_IMAGE_LOADING_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)), named: "CATEGORIES_WITH_FAILED_IMAGE_LOADING_dark")
    }
    
    
    // MARK: - Helpers
    private func makeSUT() -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "Category", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! ListViewController
        controller.loadViewIfNeeded()
        controller.tableView.showsVerticalScrollIndicator = false
        controller.tableView.showsHorizontalScrollIndicator = false
        return controller
    }
    
    private func feedWithContent() -> [ImageStub] {
        return [
            ImageStub(
                strCategory: "The East Side Gallery is an open-air gallery in Berlin. It consists of a series of murals painted directly on a 1,316 m long remnant of the Berlin Wall, located near the centre of Berlin, on Mühlenstraße in Friedrichshain-Kreuzberg. The gallery has official status as a Denkmal, or heritage-protected landmark.",
                strCategoryDescription: "East Side Gallery\nMemorial in Berlin, Germany",
                image: UIImage.make(withColor: .red)
            ),
            ImageStub(
                strCategory: "Garth Pier is a Grade II listed structure in Bangor, Gwynedd, North Wales.",
                strCategoryDescription: "Garth Pier",
                image: UIImage.make(withColor: .green)
            )
        ]
    }
    
    private func feedWithFailedImageLoading() -> [ImageStub] {
        return [
            ImageStub(
                strCategory: nil,
                strCategoryDescription: "Cannon Street, London",
                image: nil
            ),
            ImageStub(
                strCategory: nil,
                strCategoryDescription: "Brighton Seafront",
                image: nil
            )
        ]
    }
    
}


private extension ListViewController {
    func display(_ stubs: [ImageStub]) {
        let cells: [CellController] = stubs.map { stub in
            let cellController = CategoryCellController(viewModel: stub.viewModel, delegate: stub, selection: {})
            stub.controller = cellController
            return CellController(id: UUID(), cellController)
        }
        
        display(cells)
    }
}

private class ImageStub: CategoryCellControllerDelegate {
    let viewModel: CategoryViewModel
    let image: UIImage?
    weak var controller: CategoryCellController?
    
    init( strCategory: String?, strCategoryDescription: String?, image: UIImage?) {
        self.viewModel = CategoryViewModel(strCategory: strCategory, strCategoryDescription: strCategoryDescription)
        self.image = image
    }
    
    func didRequestImage() {
        controller?.display(ResourceLoadingViewModel(isLoading: false))
        
        if let image = image {
            controller?.display(image)
            controller?.display(ResourceErrorViewModel(message: .none))
        } else {
            controller?.display(ResourceErrorViewModel(message: "any"))
        }
    }
    
    func didCancelImageRequest() {}
}
