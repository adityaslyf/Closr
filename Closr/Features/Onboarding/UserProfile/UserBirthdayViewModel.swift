
//
//  UserBirthdayViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 03/05/26.
//

import SwiftUI
import Observation

@Observable
final class UserBirthdayViewModel {
    // Default to 25 years ago
    var birthday: Date = Calendar.current.date(byAdding: .year, value: -25, to: Date()) ?? Date()
    var contentVisible: Bool = false
    
    var canContinue: Bool { true }

    func onAppear() {
        withAnimation(.easeOut(duration: 0.5)) {
            contentVisible = true
        }
    }
}
