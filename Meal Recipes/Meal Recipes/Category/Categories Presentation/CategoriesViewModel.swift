//
//  CategoriesViewModel.swift
//  Meal Recipes
//
//  Created by Amin faruq on 31/10/22.
//

import Foundation

public struct CategoriesViewModel {
    public let categories: [CategoryViewModel]
}

public struct CategoryViewModel: Hashable{
    public let strCategory: String?
    public let strCategoryDescription: String?
    public let strCategoryThumb: URL
    
    public init(strCategory: String?, strCategoryDescription: String?, strCategoryThumb: URL) {
        self.strCategory = strCategory
        self.strCategoryDescription = strCategoryDescription
        self.strCategoryThumb = strCategoryThumb
    }
}
