//
//  CustomModifiers+Image.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 07/09/24.
//

import Foundation
import SwiftUI

extension Image {
    func customImageStyle(cornerRadius: CGFloat = 10.0, shadowRadius: CGFloat = 5.0) -> some View {
        self
            .resizable()
            .scaledToFill()
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: .gray, radius: shadowRadius)
    }
    
    func customImageStyleNoImage(width: CGFloat = 120, height: CGFloat = 120) -> some View {
        self.resizable()
            .scaledToFit()
            .frame(width: width, height: height)
            .clipped()
    }
}
