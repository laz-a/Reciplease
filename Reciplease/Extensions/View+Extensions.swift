//
//  View+Extensions.swift
//  Reciplease
//
//  Created by laz on 03/02/2023.
//

import SwiftUI

extension View {
    func imageData() -> Data? {
        let controller = UIHostingController(rootView: self.ignoresSafeArea())
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        let uiImage = renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }

        return uiImage.jpegData(compressionQuality: 0.8)
    }
}
