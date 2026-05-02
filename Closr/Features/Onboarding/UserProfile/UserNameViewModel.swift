
//
//  UserNameViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 03/05/26.
//

import SwiftUI
import Observation

@Observable
final class UserNameViewModel {
    var name: String = ""
    var contentVisible: Bool = false
    
    var canContinue: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func onAppear() {
        withAnimation(.easeOut(duration: 0.5)) {
            contentVisible = true
        }
    }
}
