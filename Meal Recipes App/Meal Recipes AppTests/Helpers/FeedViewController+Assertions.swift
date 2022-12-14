////
////  FeedViewController+Assertions.swift
////  EssentialFeediOSTests
////
////  Created by Amin faruq on 19/09/22.
////
//
//import XCTest
//import Meal_Recipes
//import Meal_Recipes_iOS
//
//extension CategoriesUIIntegrationTests {
//    func assertThat(_ sut: ListViewController, isRendering feed: [RemoteCategory], file: StaticString = #filePath, line: UInt = #line) {
//        sut.view.enforceLayoutCycle()
//        
//        guard sut.numberOfRenderedFeedImageViews() == feed.count else {
//            return XCTFail("Expected \(feed.count) images, got \(sut.numberOfRenderedFeedImageViews()) instead.", file: file, line: line)
//        }
//        
//        feed.enumerated().forEach { index, image in
//            assertThat(sut, hasViewConfiguredFor: image, at: index, file: file, line: line)
//        }
//    }
//    
//    func assertThat(_ sut: ListViewController, hasViewConfiguredFor image: RemoteCategory, at index: Int, file: StaticString = #filePath, line: UInt = #line) {
//        let view = sut.feedImageView(at: index)
//        
//        guard let cell = view as? CategoryCellController else {
//            return XCTFail("Expected \(FeedImageCell.self) instance, got \(String(describing: view)) instead", file: file, line: line)
//        }
//        
//        let shouldLocationBeVisible = (image.location != nil)
//        XCTAssertEqual(cell.isShowingLocation, shouldLocationBeVisible, "Expected `isShowingLocation` to be \(shouldLocationBeVisible) for image view at index (\(index))", file: file, line: line)
//        
//        XCTAssertEqual(cell.locationText, image.location, "Expected location text to be \(String(describing: image.location)) for image  view at index (\(index))", file: file, line: line)
//        
//        XCTAssertEqual(cell.descriptionText, image.description, "Expected description text to be \(String(describing: image.description)) for image view at index (\(index)", file: file, line: line)
//    }
//}
