
//
//  AppFonts.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Centralized typography system for Closr.
/// Uses the system serif for display headings (mimics the editorial look)
/// and SF Pro for body / UI text.
enum AppFonts {

    // MARK: - Display (Serif editorial style)
    static func displayLarge(size: CGFloat = 44) -> Font {
        .custom("Georgia", size: size).weight(.bold)
    }

    static func displayMedium(size: CGFloat = 36) -> Font {
        .custom("Georgia", size: size).weight(.semibold)
    }

    static func displayItalic(size: CGFloat = 44) -> Font {
        .custom("Georgia-Italic", size: size)
    }

    // MARK: - Body (SF Pro)
    static func bodyRegular(size: CGFloat = 16) -> Font {
        .system(size: size, weight: .regular, design: .default)
    }

    static func bodyMedium(size: CGFloat = 16) -> Font {
        .system(size: size, weight: .medium, design: .default)
    }

    static func bodySemibold(size: CGFloat = 16) -> Font {
        .system(size: size, weight: .semibold, design: .default)
    }

    // MARK: - Label
    static func label(size: CGFloat = 13) -> Font {
        .system(size: size, weight: .regular, design: .default)
    }

    // MARK: - Headline
    static func headline(size: CGFloat = 18) -> Font {
        .system(size: size, weight: .semibold, design: .default)
    }
}
