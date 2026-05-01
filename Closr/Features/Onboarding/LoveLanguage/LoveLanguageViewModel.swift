
//
//  LoveLanguageViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

// MARK: - Model

/// The five clinically-recognised love languages (Chapman, 1992).
enum LoveLanguage: String, CaseIterable, Identifiable {
    case words        = "words"
    case time         = "time"
    case touch        = "touch"
    case gifts        = "gifts"
    case actsOfService = "acts of service"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .words:         return "💬"
        case .time:          return "🕐"
        case .touch:         return "🤝"
        case .gifts:         return "🎁"
        case .actsOfService: return "🔧"
        }
    }

    var subtitle: String {
        switch self {
        case .words:         return "affirmation &\npraise"
        case .time:          return "quality time\ntogether"
        case .touch:         return "physical closeness"
        case .gifts:         return "thoughtful\ngestures"
        case .actsOfService: return "doing things for each other"
        }
    }
}

// MARK: - ViewModel

/// Drives `LoveLanguageView`.
@Observable
final class LoveLanguageViewModel {

    // MARK: - State
    var selected: LoveLanguage? = nil
    var contentVisible: Bool    = false
    var cardsVisible: Bool      = false

    // MARK: - Computed
    var canContinue: Bool { selected != nil }

    // MARK: - Actions
    func select(_ language: LoveLanguage) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selected = language
        }
    }

    func onContinue(completion: @escaping (LoveLanguage) -> Void) {
        guard let lang = selected else { return }
        // TODO: Persist to SwiftData UserProfile model
        completion(lang)
    }

    // MARK: - Lifecycle
    func onAppear() {
        withAnimation(.easeOut(duration: 0.45)) {
            contentVisible = true
        }
        withAnimation(.easeOut(duration: 0.5).delay(0.2)) {
            cardsVisible = true
        }
    }
}
