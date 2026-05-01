
//
//  AppColors.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Centralized color palette for the Closr design system.
/// All colors are defined here to ensure consistency across the app.
enum AppColors {

    // MARK: - Background
    static let backgroundPrimary   = Color(hex: "#0D0B0B")
    static let backgroundSecondary = Color(hex: "#1A1212")
    static let backgroundCard      = Color(hex: "#1C1515")

    // MARK: - Brand / Accent
    static let brand               = Color(hex: "#C0614A")   // terracotta-rose
    static let brandMuted          = Color(hex: "#8B3D2E")   // deeper rust for overlapping lens
    static let brandGlow           = Color(hex: "#C0614A").opacity(0.25)

    // MARK: - Text
    static let textPrimary         = Color.white
    static let textSecondary       = Color(hex: "#A09090")
    static let textAccent          = Color(hex: "#C0614A")   // used for italic "daily."

    // MARK: - UI Elements
    static let divider             = Color(hex: "#2E2020")
    static let buttonPrimary       = Color.white
    static let buttonPrimaryText   = Color(hex: "#0D0B0B")

    // MARK: - Gradients
    static let radialGlow          = RadialGradient(
        colors: [Color(hex: "#3D1A14"), Color(hex: "#0D0B0B")],
        center: .center,
        startRadius: 20,
        endRadius: 180
    )
}
