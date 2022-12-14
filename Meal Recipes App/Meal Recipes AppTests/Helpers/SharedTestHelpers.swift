//
//  SharedTestHelpers.swift
//  EssentialAppTests
//
//  Created by Amin faruq on 28/09/22.
//

import Foundation
import Meal_Recipes

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}

//func uniqueFeed() -> [RemoteCategory] {
//    return [FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())]
//}

private class DummyView: ResourceView {
    func display(_ viewModel: Any) {}
}

var loadError: String {
    LoadResourcePresenter<Any, DummyView>.loadError
}
