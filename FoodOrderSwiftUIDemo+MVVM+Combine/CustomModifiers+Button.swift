//
//  CustomModifiers+Button.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 07/09/24.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ViewModifier {
    var backgroundColor: Color = .purple
    var textColor: Color = .white
    var font: Font = .title3
    
    func body(content: Content) -> some View {
        content
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
    }
}

extension View {
    func customButtonStyle(backgroundColor: Color = .purple, textColor: Color = .white, font: Font = .title3) -> some View {
        self.modifier(CustomButtonStyle(backgroundColor: backgroundColor, textColor: textColor, font: font))
    }
}
