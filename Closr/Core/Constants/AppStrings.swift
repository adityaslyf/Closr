
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

    enum UserProfile {
        static let screenTitle         = "Your profile"
        static let nameSectionLabel    = "WHAT'S YOUR NAME?"
        static let namePlaceholder     = "Enter your name"
        static let nameHint            = "Your partner will see this name in your shared space. You can change it later."
        static let ageSectionLabel     = "YOUR AGE"
        static let ageHint             = "Used to personalise your experience. Never shown to others."
        static let relationshipLabel   = "and how long have you two been together?"
        static let stepIndicator       = "Step 1 of 3"
        static let ctaContinue         = "Continue"
        static let errorNameEmpty      = "Please enter your name to continue."
    }

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

    enum ConnectPartner {
        static let headlinePrefix     = "Connect with your "
        static let headlineItalic     = "partner"
        static let subtitle           = "Choose how you'd like to link up and begin your shared journey."

        // Option cards
        static let enterCardTitle     = "Enter a code"
        static let enterCardSubtitle  = "I have a code my partner already shared with me"
        static let shareCardTitle     = "Share my code"
        static let shareCardSubtitle  = "Generate a unique code and send it to my partner"

        // Enter code panel
        static let enterSectionLabel  = "YOUR PARTNER'S CODE"
        static let enterPlaceholder   = "e.g. CLOSR-A3B7"
        static let errorEmptyCode     = "Please enter the code your partner shared."

        // Share code panel
        static let shareSectionLabel  = "YOUR UNIQUE CODE"
        static let shareHint          = "Share this code with your partner so they can join."
        static let shareCopyButton    = "Copy Code"
        static let shareCopied        = "Copied!"

        // CTAs
        static let ctaContinue        = "Continue"
        static let ctaSkip            = "I'll do this later"
    }
}

