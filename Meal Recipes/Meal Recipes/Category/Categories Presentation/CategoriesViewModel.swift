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

public struct CategoryViewModel {
    public let strCategory: String?
    public let strCategoryDescription: String?
    
    public init(strCategory: String?, strCategoryDescription: String?) {
        self.strCategory = strCategory
        self.strCategoryDescription = strCategoryDescription
    }
}
