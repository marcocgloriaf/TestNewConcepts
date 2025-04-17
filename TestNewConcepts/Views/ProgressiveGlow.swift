//
//  ProgressiveGlow.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 12/04/25.
//

import SwiftUI
struct ProgressiveGlow: ViewModifier {
  
    let origin: CGPoint
    let progress: Double

  func body(content: Content) -> some View {
      content.visualEffect { view, proxy in
          view.colorEffect(
            ShaderLibrary.default.glow(
                .float2(origin),
                .float2(proxy.size),
                .float(3.0),
                .float(progress)
            )
          )
      }
  }
}

