//
//  InterfaceAdjustments.swift
//  Tweak Explorer
//
//  Created by Nathan Choi on 5/25/20.
//  Copyright © 2020 icycabbage. All rights reserved.
//

import SwiftUI

extension Color {
    static let teal = Color("teal")
    static let lightgray = Color("lightgray")
}

// Blured Background
struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    
    init(_ style: UIBlurEffect.Style) {
        self.style = style
    }
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

// Word Case
extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
}

// Custom Button Animation
struct CardButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.3), value: configuration.isPressed)
    }
}

// Custom Button Animation (Install)
struct InstallButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .brightness(configuration.isPressed ? -0.5 : 0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

// Custom Button Animation (Install)
struct NoReactionButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}

