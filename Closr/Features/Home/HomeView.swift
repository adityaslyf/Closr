
//
//  HomeView.swift
//  Closr
//
//  Created by Aditya Varshney on 03/05/26.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // ── Header ──────────────────────────────────────────────
                    HStack {
                        Text("Home")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundStyle(AppColors.textPrimary)
                        
                        Spacer()
                        
                        // Streak Badge
                        HStack(spacing: 4) {
                            Image(systemName: "flame.fill")
                                .foregroundStyle(AppColors.brand)
                            Text("0")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(AppColors.textPrimary)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(AppColors.backgroundSecondary)
                        )
                        .overlay(
                            Capsule()
                                .stroke(AppColors.border, lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.top, AppSpacing.md)
                    
                    // ── Nudge Icon ──────────────────────────────────────────
                    Button {
                        // Nudge Action
                    } label: {
                        ZStack(alignment: .bottomTrailing) {
                            ZStack {
                                Circle()
                                    .fill(AppColors.backgroundCard)
                                Circle()
                                    .stroke(AppColors.border, lineWidth: 1)
                                
                                Image(systemName: "paperplane.fill")
                                    .font(.system(size: 24))
                                    .foregroundStyle(AppColors.brand)
                                    .rotationEffect(.degrees(45))
                                    .offset(x: -2, y: 2)
                            }
                            .frame(width: 64, height: 64)
                            
                            // Plus Badge
                            ZStack {
                                Circle()
                                    .fill(AppColors.brand)
                                    .frame(width: 20, height: 20)
                                Image(systemName: "plus")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(AppColors.backgroundPrimary)
                            }
                            .offset(x: 2, y: 2)
                        }
                    }
                    .pressAnimation()
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.top, AppSpacing.xl)
                    
                    // ── Daily Activities Title ───────────────────────────────
                    Text("Daily Activities")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(AppColors.textPrimary)
                        .padding(.horizontal, AppSpacing.lg)
                        .padding(.top, AppSpacing.xl)
                        .padding(.bottom, AppSpacing.md)
                    
                    // ── Activities Timeline ──────────────────────────────────
                    HStack(alignment: .top, spacing: 0) {
                        
                        // Timeline Line
                        VStack(spacing: 0) {
                            timelineNode(isActive: true)
                            timelineDashedLine(height: 180)
                            timelineNode(isActive: false)
                            timelineDashedLine(height: 140)
                            timelineNode(isActive: false)
                            Spacer()
                        }
                        .frame(width: 40)
                        .padding(.top, 16)
                        
                        // Cards
                        VStack(spacing: AppSpacing.md) {
                            DailyActivityCard(
                                tag: "Question",
                                title: "What do you remember about the first time you met?",
                                iconName: "person.2.fill",
                                bgColor: Color(hex: "#E6E0F8"), // Soft Lavender
                                accentColor: Color(hex: "#392A60")
                            )
                            
                            DailyActivityCard(
                                tag: "Quiz",
                                title: "Relationship Checkup",
                                iconName: "heart.text.square.fill",
                                bgColor: Color(hex: "#FDE2E8"), // Soft Pink
                                accentColor: Color(hex: "#631F33")
                            )
                            
                            DailyActivityCard(
                                tag: "Game",
                                title: "You or Me? Character Traits",
                                iconName: "paintpalette.fill",
                                bgColor: Color(hex: "#FFF2D4"), // Soft Peach/Butter
                                accentColor: Color(hex: "#6B4912")
                            )
                        }
                        .padding(.trailing, AppSpacing.lg)
                    }
                    
                    Spacer(minLength: 100)
                }
            }
        }
    }
    
    private func timelineNode(isActive: Bool) -> some View {
        ZStack {
            Circle()
                .stroke(isActive ? AppColors.brand : AppColors.textSecondary.opacity(0.5), lineWidth: 2)
                .frame(width: 14, height: 14)
            
            if isActive {
                Circle()
                    .fill(AppColors.brand)
                    .frame(width: 6, height: 6)
            }
        }
        .frame(height: 14)
    }
    
    private func timelineDashedLine(height: CGFloat) -> some View {
        Rectangle()
            .fill(Color.clear)
            .frame(width: 2, height: height)
            .background(
                GeometryReader { geometry in
                    Path { path in
                        path.move(to: CGPoint(x: 1, y: 0))
                        path.addLine(to: CGPoint(x: 1, y: geometry.size.height))
                    }
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [6, 6]))
                    .foregroundStyle(AppColors.divider)
                }
            )
    }
}

// ── Dummy Component (Needs proper implementation) ──
struct DailyActivityCard: View {
    let tag: String
    let title: String
    let iconName: String
    let bgColor: Color
    let accentColor: Color
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: AppRadius.md)
                .fill(bgColor)
                .overlay(
                    RoundedRectangle(cornerRadius: AppRadius.md)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
            
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                Text(tag)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(accentColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule().fill(accentColor.opacity(0.12))
                    )
                
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(AppColors.textPrimary)
                    .lineLimit(3)
                    .padding(.trailing, 60) // Space for icon
                
                Spacer()
            }
            .padding(AppSpacing.md)
            
            // Icon Watermark
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: iconName)
                        .font(.system(size: 80))
                        .foregroundStyle(accentColor.opacity(0.08))
                        .offset(x: 10, y: 20)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.md))
        }
        .frame(height: tag == "Question" ? 180 : 140)
    }
}

#Preview {
    HomeView()
}
