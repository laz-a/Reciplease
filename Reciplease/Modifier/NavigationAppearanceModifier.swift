//
//  NavigationAppearanceModifier.swift
//  Reciplease
//
//  Created by laz on 23/12/2022.
//

import SwiftUI

// Navigation bar customization
struct NavigationAppearanceModifier: ViewModifier {
    init(backgroundColor: Color, foregroundColor: Color, tintColor: Color?, hideSeparator: Bool) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.font: UIFont(name: Constant.font, size: 42)!, .foregroundColor: UIColor(foregroundColor)]
        navBarAppearance.largeTitleTextAttributes = [.font: UIFont(name: Constant.font, size: 42)!, .foregroundColor: UIColor(foregroundColor)]
        navBarAppearance.backgroundColor = UIColor(backgroundColor)
        
        if hideSeparator {
            navBarAppearance.shadowColor = .clear
        }
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
        if let tintColor = tintColor {
            UINavigationBar.appearance().tintColor = UIColor(tintColor)
        }
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func navigationAppearance(backgroundColor: Color, foregroundColor: Color, tintColor: Color? = nil, hideSeparator: Bool = false) -> some View {
        self.modifier(NavigationAppearanceModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor, tintColor: tintColor, hideSeparator: hideSeparator))
    }
}
