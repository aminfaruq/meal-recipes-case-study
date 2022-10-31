//
//  CategoriesMapperTest.swift
//  Meal RecipesTests
//
//  Created by Amin faruq on 31/10/22.
//

import XCTest
import Meal_Recipes

class CategoriesMapperTest: XCTestCase {
    
    func test_map_throwsErrorOnNon2xxHTTPResponse() throws {
        let json = makeItemsJSON([])
        let samples = [199, 150, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try CategoriesMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn2xxHTTPResponseWithInvalidJSON() throws {
        let invalidJSON = Data("invalid json".utf8)
        let samples = [200, 201, 250, 280, 299]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try CategoriesMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_deliversNoItemsOn2xxHTTPResponseWithEmptyJSONList() throws {
        let emptyListJSON = makeItemsJSON([])
        let samples = [200, 201, 250, 280, 299]
        
        try samples.forEach { code in
            let result = try CategoriesMapper.map(emptyListJSON, from: HTTPURLResponse(statusCode: code))
            
            XCTAssertEqual(result, [])
        }
    }
    
    func test_map_deliversItemsOn2xxHTTPResponseWithJSONItems() throws {
        let item1 = makeItem(
            idCategory: UUID(),
            strCategory: "a message",
            strCategoryThumb: "",
            strCategoryDescription: "a username")
        
        let item2 = makeItem(
            idCategory: UUID(),
            strCategory: "another message",
            strCategoryThumb: "2020-01-01T12:31:22+00:00",
            strCategoryDescription: "")
        
        let json = makeItemsJSON([item1.json, item2.json])
        let samples = [200, 201, 250, 280, 299]
        
        try samples.forEach { code in
            let result = try CategoriesMapper.map(json, from: HTTPURLResponse(statusCode: code))
            
            XCTAssertEqual(result, [item1.model, item2.model])
        }
    }
    
    
    // MARK: - Helpers
    
    private func makeItem(idCategory: UUID, strCategory: String, strCategoryThumb: String, strCategoryDescription: String) -> (model: RemoteCategory, json: [String: Any]) {
        
        let item = RemoteCategory(idCategory: idCategory, strCategory: strCategory, strCategoryThumb: strCategoryThumb, strCategoryDescription: strCategoryDescription)
        
        let json: [String: Any] = [
            "idCategory": idCategory.uuidString,
            "strCategory": strCategory,
            "strCategoryThumb": strCategoryThumb,
            "strCategoryDescription": strCategoryDescription
        ]
        
        return (item, json)
    }
}
