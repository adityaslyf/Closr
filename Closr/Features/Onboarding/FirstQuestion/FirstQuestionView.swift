
//
//  FirstQuestionView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Final step of onboarding (or first step of the main app).
/// Shows a countdown timer, a preview of the first question, and a CTA to enter the main flow.
struct FirstQuestionView: View {

    @State private var viewModel = FirstQuestionViewModel()

    // Since this is the end of the onboarding flow, this callback should dismiss the entire stack.
    var onContinue: (() -> Void)?

    private let teal = Color(hex: "#5ECFB1")

    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Scrollable content ────────────────────────────────────
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center, spacing: 0) {

                        // Badge
                        TagBadge(
                            title: "You're in",
                            foreground: teal,
                            borderColor: teal.opacity(0.5),
                            background: teal.opacity(0.1)
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, AppSpacing.lg)
                        .opacity(viewModel.contentVisible ? 1 : 0)

                        // Countdown ring
                        CircularCountdownView(hoursLeft: 12, progress: viewModel.progress)
                            .padding(.top, AppSpacing.xxl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .scaleEffect(viewModel.contentVisible ? 1 : 0.8)

                        // Headline & Subtitle
                        headerSection
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 16)

                        // Question Card
                        questionCard
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 20)

                        Spacer(minLength: AppSpacing.xl)
                    }
                    .padding(.horizontal, AppSpacing.lg)
                }

                // ── Sticky Footer ─────────────────────────────────────────
                footerButton
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.bottom, AppSpacing.xl)
                    .opacity(viewModel.contentVisible ? 1 : 0)
            }
        }
        .navigationBarHidden(true)
        .onAppear { viewModel.onAppear() }
    }

    // MARK: - Sub-views

    private var headerSection: some View {
        VStack(spacing: AppSpacing.sm) {
            Text("your first question\nis waiting")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)
                .multilineTextAlignment(.center)
                .lineSpacing(2)

            Text("answer it now and your partner gets\nnotified instantly.")
                .font(AppFonts.bodyRegular(size: 16))
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
    }

    private var questionCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("what's something small I do that you secretly love?")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)
                .lineSpacing(4)

            Text("tap to answer — your partner can't see it\nuntil they answer too")
                .font(AppFonts.bodyItalic(size: 14))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(2)
        }
        .padding(AppSpacing.lg)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: AppRadius.md)
                .fill(AppColors.backgroundCard)
        )
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.md)
                .stroke(AppColors.border, lineWidth: 1)
        )
    }

    private var footerButton: some View {
        Button {
            viewModel.continueFlow {
                onContinue?()
            }
        } label: {
            HStack(spacing: AppSpacing.xs) {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(AppColors.textPrimary)
                } else {
                    Text("answer my first question")
                        .font(AppFonts.bodyMedium(size: 16))

                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 14, weight: .semibold))
                }
            }
            .foregroundStyle(AppColors.textPrimary)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: AppRadius.md)
                    .fill(AppColors.backgroundSecondary)
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.md)
                    .stroke(AppColors.borderActive, lineWidth: 1)
            )
        }
        .pressAnimation()
        .disabled(viewModel.isLoading)
    }
}

// MARK: - Preview
#Preview {
    FirstQuestionView()
        
}
