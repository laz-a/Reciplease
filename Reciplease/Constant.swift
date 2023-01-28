//
//  Config.swift
//  Reciplease
//
//  Created by laz on 26/01/2023.
//

import SwiftUI

struct Constant {
    static let font = "MarckScript-Regular"
    
    static let rowHeight = 120.0

    static var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.9), .black.opacity(0.3)]),
            startPoint: .bottom,
            endPoint: .center
        )
    }
    
}
