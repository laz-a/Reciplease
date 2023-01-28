//
//  ActivityIndicator.swift
//  Reciplease
//
//  Created by laz on 08/01/2023.
//

import Foundation
import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .white
        return activityIndicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        self.isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
