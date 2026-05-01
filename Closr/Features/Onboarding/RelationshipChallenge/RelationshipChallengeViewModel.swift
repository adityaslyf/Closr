
//
//  RelationshipChallengeViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

// MARK: - Model

/// The relationship challenges a user can select.
/// "nothingSpecific" is mutually exclusive with all others.
enum RelationshipChallenge: String, CaseIterable, Identifiable {
    case busySchedules   = "busy schedules"
    case longDistance    = "long distance"
    case feelingDistant  = "feeling distant"
    case communication   = "communication"
    case intimacy        = "intimacy"
    case routineBoredom  = "routine & boredom"
    case trustIssues     = "trust issues"
    case justMaintaining = "just maintaining"
    case nothingSpecific = "nothing specific"

    var id: String { rawValue }
}

// MARK: - ViewModel

@Observable
final class RelationshipChallengeViewModel {

    // MARK: - State
    var selected: Set<RelationshipChallenge> = []
    var contentVisible: Bool = false
    var chipsVisible: Bool   = false

    // MARK: - Computed
    var canContinue: Bool { !selected.isEmpty }

    // MARK: - Actions

    func toggle(_ challenge: RelationshipChallenge) {
        withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
            if challenge == .nothingSpecific {
                // "nothing specific" deselects everything else
                selected = selected.contains(.nothingSpecific) ? [] : [.nothingSpecific]
            } else {
                // Selecting any real challenge removes "nothing specific"
                selected.remove(.nothingSpecific)
                if selected.contains(challenge) {
                    selected.remove(challenge)
                } else {
                    selected.insert(challenge)
                }
            }
        }
    }

    func onContinue(completion: @escaping () -> Void) {
        guard canContinue else { return }
        // TODO: Persist selected challenges to SwiftData UserProfile
        completion()
    }

    // MARK: - Lifecycle
    func onAppear() {
        withAnimation(.easeOut(duration: 0.4)) {
            contentVisible = true
        }
        withAnimation(.easeOut(duration: 0.45).delay(0.18)) {
            chipsVisible = true
        }
    }
}
