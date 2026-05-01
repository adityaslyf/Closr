
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
    case createAccount    // → InvitePartnerView (step 2)
    case connectPartner   // → ConnectPartnerView (step 3)
    case inviteCode       // → InviteCodeView (entered from welcome "I have a code")
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
        navigationPath.append(.createAccount)
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
