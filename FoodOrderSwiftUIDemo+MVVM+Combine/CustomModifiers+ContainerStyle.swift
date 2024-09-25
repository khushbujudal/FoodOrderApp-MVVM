//
//  CustomModifiers+ContainerStyle.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 07/09/24.
//

import Foundation
import SwiftUI

struct CustomContainerStyle: ViewModifier {
    var backgroundColor: Color = .white
    var cornerRadius: CGFloat = 10.0
    var shadowColor: Color = .gray
    var shadowRadius: CGFloat = 5.0
    
    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: shadowColor, radius: shadowRadius)
    }
}

extension View {
    func customContainerStyle(backgroundColor: Color = .white, cornerRadius: CGFloat = 10.0, shadowColor: Color = .gray, shadowRadius: CGFloat = 5.0) -> some View {
        self.modifier(CustomContainerStyle(backgroundColor: backgroundColor, cornerRadius: cornerRadius, shadowColor: shadowColor, shadowRadius: shadowRadius))
    }
}
