//
//  CategoryImageDataLoader.swift
//  Meal Recipes
//
//  Created by Amin faruq on 01/11/22.
//

import Foundation

public protocol CategoryImageDataLoader {
    func loadImageData(from url: URL) throws -> Data
}
