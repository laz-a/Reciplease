//
//  ButtonStyle.swift
//  Reciplease
//
//  Created by laz on 21/12/2022.
//

import SwiftUI

struct GreenButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.top, .bottom], 10)
            .frame(width: 60)
            .foregroundColor(.white)
            .background(Color.greenButton)
            .cornerRadius(5)
    }
}

struct GrayButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.top, .bottom], 10)
            .frame(width: 60)
            .foregroundColor(.white)
            .background(Color.grayButton)
            .cornerRadius(5)
    }
}

struct GreenFullButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.top, .bottom], 10)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.greenButton)
            .cornerRadius(5)
    }
}
