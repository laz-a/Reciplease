//
//  RecipeService.swift
//  Reciplease
//
//  Created by laz on 15/12/2022.
//

import Foundation
import Alamofire

class RecipeService {
    
    static let shared = RecipeService()
    private init() {}
    
    static let url = "https://api.edamam.com/api/recipes/v2"
    private let encoding = URLEncoding(arrayEncoding: .noBrackets)
    private var parameters: [String : Any] = ["type": "public", "app_id": ApiKey.appId, "app_key": ApiKey.appKey,
                            "field": ["uri", "label", "image", "images", "source", "url", "healthLabels", "cautions", "ingredients", "calories", "glycemicIndex", "totalWeight", "totalTime", "cuisineType", "mealType", "dishType", "tags"]
                            ]

    func getRecipes(for ingredients: [String], completionHandler: @escaping (Result<[Recipe], AFError>) -> Void) {
        parameters["q"] = ingredients.joined(separator: ",")
        
        AF.request(RecipeService.url, parameters: parameters, encoding: encoding).responseDecodable(of: Edamam.self) { response in
            print(response)
            switch response.result {
            case .success(let edaman):
                completionHandler(.success(edaman.recipes))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
