
//
//  AppColors.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Centralized color palette for the Closr design system.
/// All colors are defined here to ensure consistency across the app.
///
/// Brand palette — dusty rose / warm blush pink.
/// Chosen to feel romantic and premium without being garish.
enum AppColors {

    // MARK: - Background
    /// Near-black with a very subtle warm-plum tint
    static let backgroundPrimary   = Color(hex: "#0D0A0D")
    static let backgroundSecondary = Color(hex: "#1A1220")
    static let backgroundCard      = Color(hex: "#1C1425")

    // MARK: - Brand / Accent  (rose-pink palette)
    static let brand               = Color(hex: "#D4688B")   // warm rose-pink
    static let brandMuted          = Color(hex: "#8B2B52")   // deep raspberry for lens fill
    static let brandGlow           = Color(hex: "#D4688B").opacity(0.25)

    // MARK: - Text
    static let textPrimary         = Color.white
    static let textSecondary       = Color(hex: "#A899B0")   // soft lavender-grey
    static let textAccent          = Color(hex: "#D4688B")   // used for italic "daily."

    // MARK: - UI Elements
    static let divider             = Color(hex: "#2D1A35")
    static let buttonPrimary       = Color.white
    static let buttonPrimaryText   = Color(hex: "#0D0A0D")

    // MARK: - Gradients
    static let radialGlow          = RadialGradient(
        colors: [Color(hex: "#3D1030"), Color(hex: "#0D0A0D")],
        center: .center,
        startRadius: 20,
        endRadius: 180
    )
}
