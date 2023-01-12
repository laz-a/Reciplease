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
    let next: String?
    
    let recipes: [Recipe]
    
    struct ToLinks: Decodable {
        var next: ToNext?
    }
    
    struct ToNext: Decodable {
        var href: URL
        var title: String
    }
    
    // Root coding keys
    enum CodingKeys: String, CodingKey {
        case from, to, count, hits
        case links = "_links"
    }
    
    // MARK: - Links
    enum LinksKeys: String, CodingKey {
        case next = "next"
    }

    // MARK: - Next
    enum NextKeys: String, CodingKey {
        case href, title
    }
    
    // Decode json structure
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let linksContainer = try container.nestedContainer(keyedBy: LinksKeys.self, forKey: .links)

        from = try container.decode(Int.self, forKey: .from)
        to = try container.decode(Int.self, forKey: .to)
        count = try container.decode(Int.self, forKey: .count)
        
        let hits = try container.decode([Hit].self, forKey: .hits)
        recipes = hits.map { $0.recipe }
        
        if linksContainer.contains(.next) {
            let nextContainer = try linksContainer.nestedContainer(keyedBy: NextKeys.self, forKey: .next)
            next = try nextContainer.decode(String.self, forKey: .href)
        } else {
            next = nil
        }
    }
}

struct Hit: Decodable {
    let recipe: Recipe
}

struct Recipe: Identifiable, Hashable, Decodable {
    var id: String
    var name: String
    var image: URL?
    var source: String
    var url: URL
    var healthLabels: [String]
    var cautions: [String]
    var ingredients: [Ingredient]
    var ingredientsShortList: String {
        ingredients.map { $0.food.capitalized }.joined(separator: ", ")
    }
    var ingredientsLongList: String {
        ingredients.map { "- \($0.text)" }.joined(separator: "\n")
    }
    var totalTime: Int16
    var isFavorite: Bool = false
    
    // Root coding keys
    enum CodingKeys: String, CodingKey {
        case uri, label, image, source, url, healthLabels, cautions, ingredients, ingredientsList, totalTime
    }
    
    struct Ingredient: Codable {
        let id: String
        let text: String
        let food: String
        let foodCategory: String?
        let quantity: Double
        let measure: String?
        
        // Root coding keys
        enum CodingKeys: String, CodingKey {
            case text, quantity, measure, food, foodCategory
            case id = "foodId"
        }
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Decode json structure
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .uri)
        name = try values.decode(String.self, forKey: .label)
        image = try values.decode(URL.self, forKey: .image)
        source = try values.decode(String.self, forKey: .source)
        url = try values.decode(URL.self, forKey: .url)
        healthLabels = try values.decode([String].self, forKey: .healthLabels)
        cautions = try values.decode([String].self, forKey: .cautions)
        ingredients = try values.decode([Ingredient].self, forKey: .ingredients)
        totalTime = try values.decode(Int16.self, forKey: .totalTime)
        isFavorite = false
    }
}
