
//
//  LoveLanguageView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Love language selection screen — part of the onboarding profile setup.
///
/// Layout:
///   • "Love language" category badge
///   • Headline + subtitle
///   • 2×2 grid of option cards
///   • Full-width 5th card ("acts of service")
///   • "Continue" CTA (disabled until a selection is made)
struct LoveLanguageView: View {

    // MARK: - ViewModel
    @State private var viewModel = LoveLanguageViewModel()
    @Environment(\.dismiss) private var dismiss

    // Callback injected from parent navigator
    var onContinue: ((LoveLanguage) -> Void)?

    // MARK: - Layout
    private let columns = [
        GridItem(.flexible(), spacing: AppSpacing.sm),
        GridItem(.flexible(), spacing: AppSpacing.sm)
    ]

    // The first four languages go into the 2×2 grid
    private var gridLanguages: [LoveLanguage] {
        LoveLanguage.allCases.filter { $0 != .actsOfService }
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Nav bar (no progress bar — this is a sub-step of profile) ──
                backBar
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.top, AppSpacing.md)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {

                        // ── Category badge ────────────────────────────────
                        TagBadge(title: "Love language")
                            .padding(.top, AppSpacing.lg)
                            .opacity(viewModel.contentVisible ? 1 : 0)

                        // ── Headline ──────────────────────────────────────
                        headlineSection
                            .padding(.top, AppSpacing.md)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)

                        // ── 2×2 grid ──────────────────────────────────────
                        LazyVGrid(columns: columns, spacing: AppSpacing.sm) {
                            ForEach(gridLanguages) { lang in
                                LoveLanguageCard(
                                    emoji:      lang.emoji,
                                    title:      lang.rawValue,
                                    subtitle:   lang.subtitle,
                                    isSelected: viewModel.selected == lang,
                                    action:     { viewModel.select(lang) }
                                )
                            }
                        }
                        .padding(.top, AppSpacing.lg)
                        .opacity(viewModel.cardsVisible ? 1 : 0)
                        .offset(y: viewModel.cardsVisible ? 0 : 20)

                        // ── Full-width 5th card ───────────────────────────
                        LoveLanguageCard(
                            emoji:      LoveLanguage.actsOfService.emoji,
                            title:      LoveLanguage.actsOfService.rawValue,
                            subtitle:   LoveLanguage.actsOfService.subtitle,
                            isSelected: viewModel.selected == .actsOfService,
                            action:     { viewModel.select(.actsOfService) }
                        )
                        .padding(.top, AppSpacing.sm)
                        .opacity(viewModel.cardsVisible ? 1 : 0)
                        .offset(y: viewModel.cardsVisible ? 0 : 20)

                        Spacer(minLength: AppSpacing.sm)
                    }
                    .padding(.horizontal, AppSpacing.lg)
                }

                // ── Sticky footer ─────────────────────────────────────────
                footerSection
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.bottom, AppSpacing.xl)
            }
        }
        .navigationBarHidden(true)
        .onAppear { viewModel.onAppear() }
    }

    // MARK: - Sub-views

    private var backBar: some View {
        HStack {
            Button { dismiss() } label: {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: 40, height: 40)
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(AppColors.textPrimary)
                }
            }
            .pressAnimation()
            Spacer()
        }
    }

    private var headlineSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("how do you feel\nmost loved?")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)
                .lineSpacing(2)

            Text("this personalizes every question we send you.")
                .font(AppFonts.bodyRegular(size: 16))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
        }
    }

    private var footerSection: some View {
        PrimaryButton(
            title: "continue",
            action: { viewModel.onContinue { lang in onContinue?(lang) } }
        )
        .opacity(viewModel.canContinue ? 1 : 0.4)
        .animation(.easeInOut(duration: 0.2), value: viewModel.canContinue)
    }
}

// MARK: - Preview
#Preview {
    LoveLanguageView()
        .preferredColorScheme(.dark)
}
