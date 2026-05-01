
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

    enum InvitePartner {
        static let headlinePrefix   = "Invite your "
        static let headlineItalic   = "partner"
        static let subtitle         = "Every journey is better shared. Send an invite to begin your private connection."
        static let sectionLabel     = "PARTNER'S DETAILS"
        static let fieldPlaceholder = "Email or phone number"
        static let contactSyncHint  = "Sync contacts to find them faster"
        static let ctaPrimary       = "Send Invitation"
        static let ctaSecondary     = "I'll do this later"
        static let errorEmpty       = "Please enter an email or phone number."
    }
}
