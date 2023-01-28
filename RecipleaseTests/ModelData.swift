//
//  modelData.swift
//  Reciplease
//
//  Created by laz on 18/12/2022.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    var edamam: Edamam = load("recipeData.json")
}

func load(_ filename: String) -> Edamam {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        let edamam = try decoder.decode(Edamam.self, from: data)
        return edamam
    } catch {
        fatalError("Couldn't parse \(filename) as \([Recipe].self):\n\(error)")
    }
}
