
//
//  RelationshipChallengeView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// "What's your biggest challenge right now?" — multi-select chip picker.
///
/// Layout:
///   • "Your relationship" TagBadge
///   • Bold headline + subtitle
///   • FlowLayout chip grid (multi-select, "nothing specific" is exclusive)
///   • Sticky "continue" button
struct RelationshipChallengeView: View {

    // MARK: - ViewModel
    @State private var viewModel = RelationshipChallengeViewModel()
    @Environment(\.dismiss) private var dismiss

    var onContinue: (() -> Void)?

    // MARK: - Body
    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Back button row ───────────────────────────────────────
                backBar
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.top, AppSpacing.md)

                // ── Content ───────────────────────────────────────────────
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {

                        // Badge
                        TagBadge(title: "Your relationship")
                            .padding(.top, AppSpacing.lg)
                            .opacity(viewModel.contentVisible ? 1 : 0)

                        // Headline
                        headlineSection
                            .padding(.top, AppSpacing.sm)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)
                            .animation(.easeOut(duration: 0.4), value: viewModel.contentVisible)

                        // Chip flow
                        chipsSection
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.chipsVisible ? 1 : 0)
                            .offset(y: viewModel.chipsVisible ? 0 : 16)
                            .animation(.easeOut(duration: 0.4), value: viewModel.chipsVisible)

                        Spacer(minLength: AppSpacing.sm)
                    }
                    .padding(.horizontal, AppSpacing.lg)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                // ── Sticky footer ─────────────────────────────────────────
                PrimaryButton(
                    title: "continue",
                    action: { viewModel.onContinue { onContinue?() } }
                )
                .opacity(viewModel.canContinue ? 1 : 0.4)
                .animation(.easeInOut(duration: 0.2), value: viewModel.canContinue)
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
                        .fill(AppColors.buttonBackground)
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
            Text("what's your biggest\nchallenge right now?")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)
                .lineSpacing(2)

            Text("pick all that apply. we'll focus questions here first.")
                .font(AppFonts.bodyRegular(size: 15))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
        }
    }

    private var chipsSection: some View {
        FlowLayout(horizontalSpacing: 8, verticalSpacing: 10) {
            ForEach(RelationshipChallenge.allCases) { challenge in
                ChipButton(
                    title:      challenge.rawValue,
                    isSelected: viewModel.selected.contains(challenge),
                    action:     { viewModel.toggle(challenge) }
                )
            }
        }
    }
}

// MARK: - Preview
#Preview {
    RelationshipChallengeView()
        
}
