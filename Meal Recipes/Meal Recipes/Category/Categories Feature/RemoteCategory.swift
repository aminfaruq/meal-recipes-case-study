//
//  Category.swift
//  Meal Recipes
//
//  Created by Amin faruq on 31/10/22.
//

import Foundation

public struct RemoteCategory: Equatable {
    public let idCategory: UUID
    public let strCategory: String
    public let strCategoryThumb: String
    public let strCategoryDescription: String

    public init(idCategory: UUID, strCategory: String, strCategoryThumb: String, strCategoryDescription: String) {
        self.idCategory = idCategory
        self.strCategory = strCategory
        self.strCategoryThumb = strCategoryThumb
        self.strCategoryDescription = strCategoryDescription
    }
}
