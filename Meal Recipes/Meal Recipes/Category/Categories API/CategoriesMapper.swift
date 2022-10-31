//
//  CategoriesMapper.swift
//  Meal Recipes
//
//  Created by Amin faruq on 31/10/22.
//

import Foundation

public final class CategoriesMapper {
    
    private struct Root: Decodable {
        private let categories: [Categories]
        
        private struct Categories: Decodable {
            let idCategory: String
            let strCategory: String
            let strCategoryThumb: String
            let strCategoryDescription: String
        }
        
        var categoriesList: [RemoteCategory] {
            categories.map { RemoteCategory(idCategory: $0.idCategory, strCategory: $0.strCategory, strCategoryThumb: $0.strCategoryThumb, strCategoryDescription: $0.strCategoryDescription) }
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteCategory] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        guard isOK(response), let root = try? decoder.decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        
        return root.categoriesList
    }
    
    private static func isOK(_ response: HTTPURLResponse) -> Bool {
        (200...299).contains(response.statusCode)
    }
}
