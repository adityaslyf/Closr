
//
//  UserProfileViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

/// Drives `UserProfileView` — all presentation logic and validation lives here.
@Observable
final class UserProfileViewModel {

    // MARK: - User Inputs
    var name: String            = ""
    var avatarImage: UIImage?   = nil
    var birthday: Date?         = nil         // optional birthday

    // MARK: - UI State
    var showBirthdayPicker: Bool = false
    var hasNameError: Bool      = false
    var nameErrorMessage: String = ""
    var contentVisible: Bool    = false
    var isLoading: Bool         = false

    // MARK: - Computed

    var canContinue: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    // MARK: - Actions

    func onContinue(completion: @escaping () -> Void) {
        guard canContinue else {
            hasNameError     = true
            nameErrorMessage = AppStrings.UserProfile.errorNameEmpty
            return
        }
        isLoading = true
        // TODO: Persist to SwiftData UserProfile model
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            self?.isLoading = false
            completion()
        }
    }

    func onNameChanged() {
        if hasNameError { hasNameError = false }
    }

    // MARK: - Lifecycle
    func onAppear() {
        withAnimation(.easeOut(duration: 0.55)) {
            contentVisible = true
        }
    }
}
