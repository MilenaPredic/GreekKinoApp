//
//  Extensions.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 14.2.24..
//

import SwiftUI

extension Color {
    static func forNumber(_ number: Int) -> Color {
        switch number {
        case 1...10:
            return .yellow
        case 11...20:
            return .orange
        case 21...30:
            return .red
        case 31...40:
            return .purple
        case 41...50:
            return .pink
        case 51...60:
            return .blue
        case 61...70:
            return .green
        case 71...80:
            return .purple
        default:
            return .gray
        }
    }
}

extension View {
    func blackBackground() -> some View {
        self.modifier(BackgroundModifier())
    }
}
