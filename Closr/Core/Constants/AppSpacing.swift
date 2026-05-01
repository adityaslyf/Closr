
//
//  AppSpacing.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import CoreGraphics

/// 8-pt spacing scale used throughout the Closr design system.
enum AppSpacing {
    static let xxs: CGFloat  = 4
    static let xs: CGFloat   = 8
    static let sm: CGFloat   = 12
    static let md: CGFloat   = 16
    static let lg: CGFloat   = 24
    static let xl: CGFloat   = 32
    static let xxl: CGFloat  = 48
    static let xxxl: CGFloat = 64
}

/// Corner radius tokens.
enum AppRadius {
    static let sm: CGFloat  = 8
    static let md: CGFloat  = 16
    static let lg: CGFloat  = 24
    static let pill: CGFloat = 100   // fully rounded pill buttons
}
