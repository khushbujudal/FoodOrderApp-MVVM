//
//  CustomModifiers+TextField.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 07/09/24.
//

import Foundation
import SwiftUI

struct CustomTextFieldStyle: ViewModifier {
    var borderColor: Color = .purple
    var cornerRadius: CGFloat = 10.0
    var borderWidth: CGFloat = 2.0
    
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(borderColor, style: StrokeStyle(lineWidth: borderWidth))
            )
    }
}

extension View {
    func customTextFieldStyle(borderColor: Color = .purple, cornerRadius: CGFloat = 10.0, borderWidth: CGFloat = 2.0) -> some View {
        self.modifier(CustomTextFieldStyle(borderColor: borderColor, cornerRadius: cornerRadius, borderWidth: borderWidth))
    }
}
