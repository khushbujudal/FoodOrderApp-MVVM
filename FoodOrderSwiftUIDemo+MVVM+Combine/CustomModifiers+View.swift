//
//  CustomModifiers.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 05/09/24.
//

import Foundation
import SwiftUI

struct GradientButtonModifier: ViewModifier {
    var action: () -> Void
    var title: String

    func body(content: Content) -> some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.heavy)
                .font(.title3)
                .padding()
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                .cornerRadius(40)
                .padding(.top, 50)
        }
    }
}

extension View {
    func customButton(action: @escaping () -> Void, title: String) -> some View {
        self.modifier(GradientButtonModifier(action: action, title: title))
    }
}


extension View {

    func customContainerStyle() -> some View {
        self
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .gray, radius: 5, x: 0, y: 3)
    }
    
    func customButtonStyle(isEnabled: Bool, backgroundColor: Color) -> some View {
        self
            .fontWeight(.heavy)
            .font(.title3)
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(isEnabled ? backgroundColor : backgroundColor.opacity(0.5))
            .disabled(!isEnabled)
            .cornerRadius(40)
    }
    
    func emptyMessageStyle() -> some View {
        self
            .font(.title3)
            .foregroundColor(.gray)
            .padding()
    }
}
