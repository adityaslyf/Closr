
//
//  KidsViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

enum KidsOption: String, CaseIterable, Identifiable {
    case yes = "Yes"
    case no  = "No"

    var id: String { rawValue }
}

@Observable
final class KidsViewModel {
    var selectedOption: KidsOption? = nil
    var contentVisible: Bool = false

    var canContinue: Bool {
        selectedOption != nil
    }

    func select(_ option: KidsOption) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selectedOption = option
        }
    }

    func onAppear() {
        withAnimation(.easeOut(duration: 0.5)) {
            contentVisible = true
        }
    }
}
