
//
//  RelationshipStatusViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

enum RelationshipStatusOption: String, CaseIterable, Identifiable {
    case inRelationship   = "In a relationship"
    case engaged          = "Engaged"
    case married          = "Married"
    case civilPartnership = "In a civil partnership"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .inRelationship:   return "heart.fill"
        case .engaged:          return "sparkles" // Placeholder for ring
        case .married:          return "heart.circle.fill" // Placeholder for double hearts
        case .civilPartnership: return "building.columns.fill" // Placeholder for scales
        }
    }
}

@Observable
final class RelationshipStatusViewModel {
    var selectedStatus: RelationshipStatusOption? = nil
    var contentVisible: Bool = false

    // In a real app, this would be injected from a shared OnboardingState
    var partnerName: String = "your partner" 

    var canContinue: Bool {
        selectedStatus != nil
    }

    func select(_ status: RelationshipStatusOption) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selectedStatus = status
        }
    }

    func onAppear() {
        withAnimation(.easeOut(duration: 0.5)) {
            contentVisible = true
        }
    }
}
