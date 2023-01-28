//
//  FontStyle.swift
//  Reciplease
//
//  Created by laz on 25/01/2023.
//

import SwiftUI

struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
//    var name: String
    var size: Double

    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.system(size: scaledSize))
//        font(.custom(name, size: scaledSize))
    }
}

extension View {
    func reciTitle() -> some View {
        return self.modifier(ScaledFont(size: 20))
    }
    
    
    func reciTitle2() -> some View {
        return self.modifier(ScaledFont(size: 12))
    }
}
