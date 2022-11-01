//
//  CategoryImageDataMapper.swift
//  Meal Recipes
//
//  Created by Amin faruq on 01/11/22.
//

import Foundation

public final class CategoryImageDataMapper {
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Data {
        guard response.isOK, !data.isEmpty else {
            throw Error.invalidData
        }
        
        return data
    }
}
