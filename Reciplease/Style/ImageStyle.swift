//
//  ImageStyle.swift
//  Reciplease
//
//  Created by laz on 24/01/2023.
//

import SwiftUI

extension Image {
    func backgroundStyle(height: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: height)
            .clipped()
    }
}
