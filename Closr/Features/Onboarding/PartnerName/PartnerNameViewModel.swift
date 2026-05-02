
//
//  PartnerNameViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

@Observable
final class PartnerNameViewModel {
    var partnerName: String = ""
    var contentVisible: Bool = false

    var canContinue: Bool {
        !partnerName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func onAppear() {
        withAnimation(.easeOut(duration: 0.5)) {
            contentVisible = true
        }
    }
}
