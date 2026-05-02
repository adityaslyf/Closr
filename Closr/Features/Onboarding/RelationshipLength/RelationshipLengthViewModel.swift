
//
//  RelationshipLengthViewModel.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import Observation

@Observable
final class RelationshipLengthViewModel {
    var relationshipDate: Date? = nil
    var showDatePicker: Bool = false
    var contentVisible: Bool = false

    var canContinue: Bool {
        relationshipDate != nil
    }

    var dynamicHeadline: String {
        guard let date = relationshipDate else { return "" }
        let years = Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0
        if years < 1 {
            return "The beginning of something special!"
        } else if years < 3 {
            return "Still going strong after these first years!"
        } else {
            return "A solid foundation built over years!"
        }
    }

    var dynamicSubtitle: String {
        guard let date = relationshipDate else { return "" }
        let years = Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0
        if years < 1 {
            return "You're in the exciting early stages. Enjoy discovering more about each other every day."
        } else if years < 3 {
            return "Here’s to you. You’re past the honeymoon stage and forming a much deeper partnership. Establishing shared goals will be crucial."
        } else {
            return "You've shared so many memories. Now is the perfect time to reignite the spark and reflect on your incredible journey together."
        }
    }

    func onAppear() {
        withAnimation(.easeOut(duration: 0.5)) {
            contentVisible = true
        }
    }
}
