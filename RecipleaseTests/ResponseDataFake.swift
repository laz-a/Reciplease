//
//  ResponseDataFake.swift
//  RecipleaseTests
//
//  Created by laz on 22/01/2023.
//

import Foundation

class ResponseDataFake {
    // Success response
    static let responseOk = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!

    // Error response
    static let responseNok = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!

    // Custom error
    class FakeError: Error {}
    static let error = FakeError()

    // Incorrect data
    static let incorrectData = "erreur".data(using: .utf8)!

// MARK: - Recipes
//
    static var recipes: Data? {
        let bundle = Bundle(for: ResponseDataFake.self)
        // Read json from Weather.json
        let url = bundle.url(forResource: "recipeData", withExtension: "json")
        if let data = try? Data(contentsOf: url!) {
            return data
        }
        return nil
    }
}
