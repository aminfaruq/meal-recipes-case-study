//
//  Category.swift
//  Meal Recipes
//
//  Created by Amin faruq on 31/10/22.
//

import Foundation

//public struct RemoteCategories {
//    public let categories: [RemoteCategory]
//    
//    public init(categories: [RemoteCategory]) {
//        self.categories = categories
//    }
//}

public struct RemoteCategory: Hashable {
    public let idCategory: String
    public let strCategory: String
    public let strCategoryThumb: URL
    public let strCategoryDescription: String

    public init(idCategory: String, strCategory: String, strCategoryThumb: URL, strCategoryDescription: String) {
        self.idCategory = idCategory
        self.strCategory = strCategory
        self.strCategoryThumb = strCategoryThumb
        self.strCategoryDescription = strCategoryDescription
    }
}
