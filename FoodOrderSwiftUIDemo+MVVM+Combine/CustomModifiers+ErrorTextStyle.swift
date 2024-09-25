//
//  CustomModifiers+ErrorTextStyle.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 07/09/24.
//

import Foundation
import SwiftUI

struct ErrorTextStyle: ViewModifier {
    var errorColor: Color = .red
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(errorColor)
            .padding(.horizontal)
    }
}

extension View {
    func errorTextStyle(errorColor: Color = .red) -> some View {
        self.modifier(ErrorTextStyle(errorColor: errorColor))
    }
}
