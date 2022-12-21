//
//  Edamam.swift
//  Reciplease
//
//  Created by laz on 15/12/2022.
//

import Foundation

struct Edamam: Decodable {
    let from: Int
    let to: Int
    let count: Int
    
    let recipes: [Recipe]
    
    // Root coding keys
    enum CodingKeys: String, CodingKey {
        case from, to, count, hits
    }
    
    // Decode json structure
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let hits = try values.decode([Hit].self, forKey: .hits)
        
        from = try values.decode(Int.self, forKey: .from)
        to = try values.decode(Int.self, forKey: .to)
        count = try values.decode(Int.self, forKey: .count)
        recipes = hits.map { $0.recipe }
    }
}

struct Hit: Codable {
    let recipe: Recipe
}

struct Recipe: Codable, Hashable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let healthLabels: [String]
    let cautions: [String]
    let ingredients: [Ingredient]
    var ingredientsList: String {
        ingredients.map { "- \($0.text) \n" }.joined()
    }
    let totalTime: Int
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.uri == rhs.uri
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uri)
    }
}

struct Ingredient: Codable {
    let text: String
    let quantity: Double
    let measure: String?
    let food: String
    let foodCategory: String
    let foodId: String
    let image: String?
}
