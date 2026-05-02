
//
//  ValuePropositionViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

@Observable
final class ValuePropositionViewModel {
    var contentVisible: Bool = false
    var cardsVisible: Bool = false

    func onAppear() {
        withAnimation(.easeOut(duration: 0.5)) {
            contentVisible = true
        }
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.2)) {
            cardsVisible = true
        }
    }
}
