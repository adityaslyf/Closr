
//
//  InvitePartnerViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

/// Drives the `InvitePartnerView` — all presentation logic lives here.
@Observable
final class InvitePartnerViewModel {

    // MARK: - State
    var contactInput: String  = ""
    var isSending: Bool       = false
    var hasError: Bool        = false
    var errorMessage: String  = ""

    // MARK: - Entry animations
    var contentVisible: Bool  = false

    // MARK: - Computed
    var canSend: Bool {
        !contactInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    // MARK: - Actions

    /// Validate input and fire the invite.
    func sendInvitation(onSuccess: @escaping () -> Void) {
        guard canSend else {
            hasError = true
            errorMessage = AppStrings.InvitePartner.errorEmpty
            return
        }

        hasError = false
        isSending = true

        // TODO: Replace with real network/SwiftData call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.isSending = false
            onSuccess()
        }
    }

    /// User chose to skip this step.
    func skipForNow(onSkip: @escaping () -> Void) {
        onSkip()
    }

    /// Trigger contact sync (future: ContactsKit integration).
    func syncContacts() {
        // TODO: Request CNContactStore authorisation and surface picker
    }

    // MARK: - Lifecycle
    func onAppear() {
        withAnimation(.easeOut(duration: 0.55)) {
            contentVisible = true
        }
    }
}
