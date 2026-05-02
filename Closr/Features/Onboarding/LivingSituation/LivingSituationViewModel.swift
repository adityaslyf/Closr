
//
//  LivingSituationViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

enum LivingSituationOption: String, CaseIterable, Identifiable {
    case liveTogether   = "We live together"
    case liveNearby     = "We live separately, nearby"
    case longDistance   = "We live separately, long distance"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .liveTogether: return "house.fill"
        case .liveNearby:   return "house.and.flag.fill" // Or map.fill
        case .longDistance: return "airplane"
        }
    }
}

@Observable
final class LivingSituationViewModel {
    var selectedSituation: LivingSituationOption? = nil
    var contentVisible: Bool = false

    var canContinue: Bool {
        selectedSituation != nil
    }

    func select(_ situation: LivingSituationOption) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selectedSituation = situation
        }
    }

    func onAppear() {
        withAnimation(.easeOut(duration: 0.5)) {
            contentVisible = true
        }
    }
}
