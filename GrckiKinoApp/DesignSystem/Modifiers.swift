//
//  Modifiers.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 15.2.24..
//

import SwiftUI

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .padding(.top, 50)
            .background(Color.black.opacity(0.90))
            .edgesIgnoringSafeArea(.all)
    }
}
