
//
//  AppStrings.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import Foundation

/// Localization-ready string constants.
/// In future iterations these keys will map to Localizable.strings.
enum AppStrings {

    enum Onboarding {
        static let appName         = "Closr"
        static let headlineTop     = "Deeper\nconnection,"
        static let headlineItalic  = "daily."
        static let subtitle        = "Discover a private space designed to bring\nyou and your partner closer than ever."
        static let ctaPrimary      = "Start Journey"
        static let ctaSecondary    = "I have an invite code"
    }

    enum InviteCode {
        static let title           = "Enter Your Invite Code"
        static let placeholder     = "e.g. CLOSR-XXXX"
        static let cta             = "Continue"
    }
}
