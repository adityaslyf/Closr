
//
//  View+Modifiers.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

// MARK: - Press Animation Modifier

/// Shrinks the view slightly on press to give tactile feedback.
struct PressAnimationModifier: ViewModifier {
    @State private var isPressed = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: isPressed)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in isPressed = true  }
                    .onEnded   { _ in isPressed = false }
            )
    }
}

extension View {
    /// Applies a press-down scale animation for interactive elements.
    func pressAnimation() -> some View {
        modifier(PressAnimationModifier())
    }
}

// MARK: - Shimmer Modifier (reserved for future skeleton states)

/// Convenience to hide / show a view without removing it from the layout.
extension View {
    @ViewBuilder
    func isHidden(_ hidden: Bool) -> some View {
        if hidden { self.hidden() } else { self }
    }
}
