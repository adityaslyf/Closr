
//
//  Color+Hex.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

extension Color {
    /// Initialise a `Color` from a hex string.
    /// Supports `#RRGGBB` and `#RRGGBBAA` formats (with or without leading `#`).
    init(hex: String) {
        let cleaned = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&rgb)

        let length = cleaned.count
        let r, g, b, a: Double

        switch length {
        case 6:
            r = Double((rgb >> 16) & 0xFF) / 255
            g = Double((rgb >>  8) & 0xFF) / 255
            b = Double( rgb        & 0xFF) / 255
            a = 1.0
        case 8:
            r = Double((rgb >> 24) & 0xFF) / 255
            g = Double((rgb >> 16) & 0xFF) / 255
            b = Double((rgb >>  8) & 0xFF) / 255
            a = Double( rgb        & 0xFF) / 255
        default:
            r = 0; g = 0; b = 0; a = 1
        }

        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
