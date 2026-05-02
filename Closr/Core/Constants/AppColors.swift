
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
extension Color {
    init(lightHex: String, darkHex: String) {
        self.init(UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(Color(hex: darkHex))
            } else {
                return UIColor(Color(hex: lightHex))
            }
        })
    }
}

enum AppColors {

    // MARK: - Background
    static let backgroundPrimary   = Color(hex: "#FAFAFC") // Premium off-white / cream
    static let backgroundSecondary = Color(hex: "#FFFFFF") // Pure white
    static let backgroundCard      = Color(hex: "#FFFFFF") // Pure white for standard cards

    // MARK: - Brand / Accent  (rose-pink palette)
    static let brand               = Color(hex: "#D4688B")
    static let brandMuted          = Color(hex: "#FDE8ED")
    static let brandGlow           = Color(hex: "#D4688B").opacity(0.15)

    // MARK: - Text
    static let textPrimary         = Color(hex: "#1A1A24") // Deep premium slate
    static let textSecondary       = Color(hex: "#8E8E9F") // Soft slate grey
    static let textAccent          = Color(hex: "#D4688B")

    // MARK: - UI Elements
    static let divider             = Color(hex: "#E5E5EA")
    static let buttonPrimary       = Color(hex: "#D4688B")
    static let buttonPrimaryText   = Color.white
    
    // Borders
    static let border              = Color.black.opacity(0.06)
    static let buttonBackground    = Color.black.opacity(0.04)
    static let borderActive        = Color.black.opacity(0.12)

    // MARK: - Gradients
    static let radialGlow          = RadialGradient(
        colors: [Color(hex: "#FFFFFF"), Color(hex: "#FAFAFC")],
        center: .center,
        startRadius: 20,
        endRadius: 180
    )
}
