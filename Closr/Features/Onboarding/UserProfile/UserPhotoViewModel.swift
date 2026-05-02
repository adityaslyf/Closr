
//
//  UserPhotoViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 03/05/26.
//

import SwiftUI
import Observation

@Observable
final class UserPhotoViewModel {
    var avatarImage: UIImage? = nil
    var contentVisible: Bool = false
    
    var canContinue: Bool { true }

    func onAppear() {
        withAnimation(.easeOut(duration: 0.5)) {
            contentVisible = true
        }
    }
}
