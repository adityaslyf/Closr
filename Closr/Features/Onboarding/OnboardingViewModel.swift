
//
//  OnboardingViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

/// Navigation destination options from the onboarding welcome screen.
enum OnboardingDestination: Hashable {
    case userName              // → UserNameView             (step 1a)
    case userBirthday          // → UserBirthdayView         (step 1b)
    case userPhoto             // → UserPhotoView            (step 1c)
    case gender                // → GenderView               (step 1a)
    case partnerName           // → PartnerNameView          (step 1b)
    case relationshipStatus    // → RelationshipStatusView   (step 1c)
    case relationshipLength    // → RelationshipLengthView   (step 1d)
    case livingSituation       // → LivingSituationView      (step 1e)
    case kids                  // → KidsView                 (step 1f)
    case loveLanguage          // → LoveLanguageView         (step 1g)
    case relationshipChallenge // → RelationshipChallengeView (step 1h)
    case valueProposition      // → ValuePropositionView     (step 1i)
    case paywall               // → PaywallView               (step 1j)
    case connectPartner        // → ConnectPartnerView        (step 2)
    case inviteCode            // → ConnectPartnerView via "I have a code"
    case firstQuestion         // → FirstQuestionView         (step 4)
}

/// Drives the `WelcomeView` state — keeps the view purely declarative.
/// Uses Swift's `@Observable` macro (iOS 17+) for fine-grained observation.
@Observable
final class OnboardingViewModel {

    // MARK: - Navigation
    var navigationPath: [OnboardingDestination] = []

    // MARK: - Entry animations
    var logoVisible: Bool      = false
    var headlineVisible: Bool  = false
    var buttonsVisible: Bool   = false

    // MARK: - Actions

    /// User tapped the primary "Start Journey" CTA.
    func startJourney() {
        navigationPath.append(.userName)
    }

    /// User tapped "I have an invite code".
    func enterInviteCode() {
        navigationPath.append(.inviteCode)
    }

    // MARK: - Lifecycle

    /// Call this from `.onAppear` on `WelcomeView` to trigger entrance animations.
    func onAppear() {
        withAnimation(.easeOut(duration: 0.7)) {
            logoVisible = true
        }
        withAnimation(.easeOut(duration: 0.6).delay(0.45)) {
            headlineVisible = true
        }
        withAnimation(.easeOut(duration: 0.5).delay(0.75)) {
            buttonsVisible = true
        }
    }
}
