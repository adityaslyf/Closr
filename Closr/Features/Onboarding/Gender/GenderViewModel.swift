
//
//  GenderViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

enum GenderOption: String, CaseIterable, Identifiable {
    case female         = "Female"
    case male           = "Male"
    case nonBinary      = "Non-binary"
    case preferNotToSay = "Prefer not to say"

    var id: String { rawValue }
}

@Observable
final class GenderViewModel {
    var selectedGender: GenderOption? = nil
    var contentVisible: Bool = false

    var canContinue: Bool {
        selectedGender != nil
    }

    func select(_ gender: GenderOption) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selectedGender = gender
        }
    }

    func onAppear() {
        withAnimation(.easeOut(duration: 0.5)) {
            contentVisible = true
        }
    }
}
