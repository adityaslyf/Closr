
//
//  ConnectPartnerViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

/// Describes which connection path the user has chosen.
enum ConnectionMode: Hashable {
    case enterCode    // User has a code their partner shared
    case shareCode    // User wants to generate & share their own code
}

/// Drives `ConnectPartnerView`.
@Observable
final class ConnectPartnerViewModel {

    // MARK: - State
    var selectedMode: ConnectionMode? = nil
    var isLoading: Bool               = false
    var contentVisible: Bool          = false

    // Generated share code (shown when mode = .shareCode)
    var shareCode: String             = ""

    // Input code (entered when mode = .enterCode)
    var enteredCode: String           = ""
    var hasCodeError: Bool            = false
    var codeErrorMessage: String      = ""

    // MARK: - Computed
    var canContinue: Bool {
        selectedMode != nil
    }

    // MARK: - Actions

    func select(mode: ConnectionMode) {
        withAnimation(.easeInOut(duration: 0.2)) {
            selectedMode = mode
        }
        // Auto-generate a share code when that path is picked
        if mode == .shareCode, shareCode.isEmpty {
            shareCode = Self.generateCode()
        }
        hasCodeError = false
    }

    func continueFlow(onEnterCode: @escaping () -> Void,
                      onShareCode: @escaping (String) -> Void) {
        guard let mode = selectedMode else { return }

        switch mode {
        case .enterCode:
            let trimmed = enteredCode.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else {
                hasCodeError = true
                codeErrorMessage = AppStrings.ConnectPartner.errorEmptyCode
                return
            }
            isLoading = true
            // TODO: Validate code via network / SwiftData
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
                self?.isLoading = false
                onEnterCode()
            }

        case .shareCode:
            onShareCode(shareCode)
        }
    }

    // MARK: - Lifecycle
    func onAppear() {
        withAnimation(.easeOut(duration: 0.55)) {
            contentVisible = true
        }
    }

    // MARK: - Helpers
    private static func generateCode() -> String {
        let chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
        let part  = (0..<4).map { _ in String(chars.randomElement()!) }.joined()
        return "CLOSR-\(part)"
    }
}
