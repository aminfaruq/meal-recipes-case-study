//
//  CategoriesPresenter.swift
//  Meal Recipes
//
//  Created by Amin faruq on 31/10/22.
//

import Foundation

public final class CategoriesPresenter {
    public static func map(_ categories: [RemoteCategory]) -> CategoriesViewModel {
        
        return CategoriesViewModel(categories: categories.map{ category in
            CategoryViewModel(strCategory: category.strCategory, strCategoryDescription: category.strCategoryDescription)
        })
    }
}
