//
//  TabbarAppearanceModifier.swift
//  Reciplease
//
//  Created by laz on 24/12/2022.
//

import SwiftUI

struct TabbarAppearanceModifier: ViewModifier {
    init(backgroundColor: Color) {
        let bigFont = UIFont.systemFont(ofSize: 32)
        let textAttributes = [NSAttributedString.Key.font: bigFont]

        UITabBarItem.appearance().setTitleTextAttributes(textAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(textAttributes, for: .selected)

        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = textAttributes
        tabBarItemAppearance.selected.titleTextAttributes = textAttributes

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(backgroundColor)
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance

        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func tabbarAppearance(backgroundColor: Color) -> some View {
        self.modifier(TabbarAppearanceModifier(backgroundColor: backgroundColor))
    }
}
