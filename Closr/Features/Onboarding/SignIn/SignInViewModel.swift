
//
//  SignInViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 03/05/26.
//

import SwiftUI
import Observation

@Observable
final class SignInViewModel {
    var contentVisible: Bool = false

    func onAppear() {
        withAnimation(.easeOut(duration: 0.5)) {
            contentVisible = true
        }
    }
}
