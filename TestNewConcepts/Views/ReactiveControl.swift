//
//  ReactiveControl.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 12/04/25.
//

import SwiftUI

struct ReactiveControl: View {
    private enum DragState {
      case inactive
      case dragging
    }
    @State private var glowAnimationID: UUID?
    @GestureState private var dragState: DragState = .inactive
    @State private var dragLocation: CGPoint?

  var body: some View {
    GeometryReader { proxy in
      ZStack {
          let dragLocation = dragLocation ?? .zero
        Capsule()
          .fill(.black)
          Capsule()
              .strokeBorder(Color.white, style: .init(lineWidth: 1.0))
        Capsule()
              .glow(fill: .palette, lineWidth: 4.0)
              .keyframeAnimator(
                initialValue: .zero,
                trigger: glowAnimationID,
                content: { view, elapsedTime in
                    view.modifier(
                        ProgressiveGlow(
                            origin: dragLocation,
                            progress: elapsedTime
                        )
                    )
                },
                keyframes: { _ in
                    if glowAnimationID != nil {
                        MoveKeyframe(.zero)
                      LinearKeyframe(
                        1.0,
                        duration: 0.4
                      )
                    } else {
                      MoveKeyframe(1.0)
                      LinearKeyframe(
                        .zero,
                        duration: 0.4
                      )
                    }
                }
              )
      }
      .gesture(
        DragGesture(
          minimumDistance: .zero
        )
        .updating(
          $dragState,
          body: { gesture, state, _ in
              switch state {
              case .inactive:
                  dragLocation = gesture.location
                  glowAnimationID = UUID()
                  state = .dragging
              case .dragging:
                  let location = gesture.location
                  let size = proxy.size
                  
                  dragLocation = CGPoint(
                    x: location.x.clamp(
                        min: .zero,
                        max: size.width
                    ),
                    y: location.y.clamp(
                        min: .zero,
                        max: size.height
                    )
                  )
              }
          }
        )
        .onEnded { _ in
            glowAnimationID = nil
        }
      )
    }
  }
}

extension Comparable where Self: AdditiveArithmetic {
  func clamp(min: Self, max: Self) -> Self {
    if self < min { return min }
    if self > max { return max }
    return self
  }
}

#Preview {
  ZStack {
    Color.black.ignoresSafeArea()
    ReactiveControl()
      .frame(
        width: 240.0,
        height: 100.0
      )
  }
}

