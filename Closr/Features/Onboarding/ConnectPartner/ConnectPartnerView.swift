
//
//  ConnectPartnerView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Step 3 of the onboarding flow.
/// The user picks **one** of two connection paths:
///   1. **Enter a code** — type in the code their partner shared
///   2. **Share my code** — a unique code is generated; they copy & send it
///
/// The contextual input panel slides in beneath the option cards
/// depending on which card is selected.
struct ConnectPartnerView: View {

    // MARK: - ViewModel
    @State private var viewModel = ConnectPartnerViewModel()
    @Environment(\.dismiss) private var dismiss

    // Callbacks
    var onConnected: (() -> Void)?
    var onSkip: (() -> Void)?

    // MARK: - Focus
    @FocusState private var isCodeFieldFocused: Bool
    @State private var codeCopied = false

    // MARK: - Body
    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Nav bar ───────────────────────────────────────────────
                OnboardingNavBar(totalSteps: 3, currentStep: 3) {
                    dismiss()
                }
                .padding(.horizontal, AppSpacing.lg)
                .padding(.top, AppSpacing.md)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // ── App header ────────────────────────────────────
                        appHeader
                            .padding(.top, AppSpacing.xl)

                        // ── Logo mark ─────────────────────────────────────
                        ClosrLogoMark()
                            .scaleEffect(0.52)
                            .frame(height: 136)
                            .padding(.top, AppSpacing.xs)

                        // ── Headline ──────────────────────────────────────
                        headlineSection
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 14)

                        // ── Option cards ──────────────────────────────────
                        optionCards
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 18)

                        // ── Contextual input panel ────────────────────────
                        if viewModel.selectedMode != nil {
                            contextPanel
                                .padding(.top, AppSpacing.lg)
                                .transition(.asymmetric(
                                    insertion: .move(edge: .bottom).combined(with: .opacity),
                                    removal:   .opacity
                                ))
                        }

                        // ── CTAs ──────────────────────────────────────────
                        buttonSection
                            .padding(.top, AppSpacing.xl)
                            .padding(.bottom, AppSpacing.xxl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                    }
                    .padding(.horizontal, AppSpacing.lg)
                    .animation(.easeInOut(duration: 0.35), value: viewModel.selectedMode)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear { viewModel.onAppear() }
        .onTapGesture { isCodeFieldFocused = false }
    }

    // MARK: - Sub-views

    private var appHeader: some View {
        VStack(spacing: AppSpacing.xs) {
            Text(AppStrings.Onboarding.appName)
                .font(AppFonts.headline(size: 22))
                .foregroundStyle(AppColors.textPrimary)
                .tracking(1.5)

            RoundedRectangle(cornerRadius: 2)
                .fill(AppColors.brand)
                .frame(width: 28, height: 2)
        }
    }

    private var headlineSection: some View {
        VStack(spacing: AppSpacing.xs) {
            // Mixed-style headline on one line
            (
                Text(AppStrings.ConnectPartner.headlinePrefix)
                    .font(AppFonts.displayMedium(size: 34))
                    .foregroundColor(AppColors.textPrimary)
                +
                Text(AppStrings.ConnectPartner.headlineItalic)
                    .font(AppFonts.displayItalic(size: 34))
                    .foregroundColor(AppColors.textAccent)
            )
            .multilineTextAlignment(.center)

            Text(AppStrings.ConnectPartner.subtitle)
                .font(AppFonts.bodyRegular(size: 15))
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.top, AppSpacing.xxs)
                .padding(.horizontal, AppSpacing.xs)
        }
    }

    private var optionCards: some View {
        VStack(spacing: AppSpacing.sm) {

            // ── Card 1: Enter a code ──────────────────────────────────────
            ConnectionOptionCard(
                icon:       "key.fill",
                title:      AppStrings.ConnectPartner.enterCardTitle,
                subtitle:   AppStrings.ConnectPartner.enterCardSubtitle,
                isSelected: viewModel.selectedMode == .enterCode,
                action:     { viewModel.select(mode: .enterCode) }
            )

            // ── OR divider ────────────────────────────────────────────────
            orDivider

            // ── Card 2: Share my code ─────────────────────────────────────
            ConnectionOptionCard(
                icon:       "square.and.arrow.up",
                title:      AppStrings.ConnectPartner.shareCardTitle,
                subtitle:   AppStrings.ConnectPartner.shareCardSubtitle,
                isSelected: viewModel.selectedMode == .shareCode,
                action:     { viewModel.select(mode: .shareCode) }
            )
        }
    }

    private var orDivider: some View {
        HStack(spacing: AppSpacing.sm) {
            Rectangle()
                .fill(Color.white.opacity(0.1))
                .frame(height: 1)

            Text("OR")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)
                .tracking(1.5)

            Rectangle()
                .fill(Color.white.opacity(0.1))
                .frame(height: 1)
        }
    }

    /// Contextual panel that morphs based on the selected mode.
    @ViewBuilder
    private var contextPanel: some View {
        switch viewModel.selectedMode {
        case .enterCode:
            enterCodePanel
        case .shareCode:
            shareCodePanel
        case .none:
            EmptyView()
        }
    }

    // MARK: - Enter Code Panel

    private var enterCodePanel: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {

            Text(AppStrings.ConnectPartner.enterSectionLabel)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)
                .tracking(1.8)

            // Text field
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: AppRadius.md)
                    .fill(AppColors.backgroundCard)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppRadius.md)
                            .stroke(
                                viewModel.hasCodeError
                                    ? AppColors.brand.opacity(0.7)
                                    : (isCodeFieldFocused
                                        ? AppColors.brand.opacity(0.45)
                                        : Color.white.opacity(0.06)),
                                lineWidth: 1
                            )
                    )
                    .frame(height: 56)

                if viewModel.enteredCode.isEmpty {
                    Text(AppStrings.ConnectPartner.enterPlaceholder)
                        .font(AppFonts.bodyRegular(size: 16))
                        .foregroundStyle(AppColors.textSecondary.opacity(0.6))
                        .padding(.horizontal, AppSpacing.md)
                }

                TextField("", text: $viewModel.enteredCode)
                    .font(AppFonts.bodySemibold(size: 16))
                    .foregroundStyle(AppColors.textPrimary)
                    .tint(AppColors.brand)
                    .padding(.horizontal, AppSpacing.md)
                    .frame(height: 56)
                    .focused($isCodeFieldFocused)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.characters)
                    .onChange(of: viewModel.enteredCode) { _, _ in
                        viewModel.hasCodeError = false
                    }
            }

            if viewModel.hasCodeError {
                Text(viewModel.codeErrorMessage)
                    .font(AppFonts.label(size: 12))
                    .foregroundStyle(AppColors.brand)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }

    // MARK: - Share Code Panel

    private var shareCodePanel: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {

            Text(AppStrings.ConnectPartner.shareSectionLabel)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)
                .tracking(1.8)

            // Generated code display + copy button
            HStack(spacing: AppSpacing.sm) {

                // Code pill
                Text(viewModel.shareCode)
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                    .foregroundStyle(AppColors.textPrimary)
                    .tracking(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, AppSpacing.md)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: AppRadius.md)
                            .fill(AppColors.backgroundCard)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppRadius.md)
                                    .stroke(AppColors.brand.opacity(0.3), lineWidth: 1)
                            )
                    )

                // Copy button
                Button {
                    UIPasteboard.general.string = viewModel.shareCode
                    withAnimation(.spring(response: 0.3)) { codeCopied = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation { codeCopied = false }
                    }
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: codeCopied ? "checkmark" : "doc.on.doc")
                            .font(.system(size: 14, weight: .medium))
                        Text(codeCopied
                             ? AppStrings.ConnectPartner.shareCopied
                             : AppStrings.ConnectPartner.shareCopyButton)
                            .font(AppFonts.bodyMedium(size: 14))
                    }
                    .foregroundStyle(codeCopied ? AppColors.brand : AppColors.textPrimary)
                    .padding(.horizontal, AppSpacing.md)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: AppRadius.md)
                            .fill(codeCopied
                                  ? AppColors.brand.opacity(0.12)
                                  : Color.white.opacity(0.08))
                    )
                }
                .pressAnimation()
            }

            Text(AppStrings.ConnectPartner.shareHint)
                .font(AppFonts.bodyRegular(size: 13))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(3)

            // Native share sheet
            ShareLink(item: viewModel.shareCode) {
                HStack(spacing: AppSpacing.xs) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 14, weight: .medium))
                    Text("Share via…")
                        .font(AppFonts.bodyMedium(size: 14))
                }
                .foregroundStyle(AppColors.brand)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: AppRadius.md)
                        .stroke(AppColors.brand.opacity(0.35), lineWidth: 1)
                )
            }
            .pressAnimation()
        }
    }

    // MARK: - Buttons

    private var buttonSection: some View {
        VStack(spacing: AppSpacing.xs) {
            PrimaryButton(
                title: AppStrings.ConnectPartner.ctaContinue,
                action: {
                    viewModel.continueFlow(
                        onEnterCode: { onConnected?() },
                        onShareCode: { _ in onConnected?() }
                    )
                },
                isLoading: viewModel.isLoading
            )
            .opacity(viewModel.canContinue ? 1 : 0.45)

            GhostButton(
                title: AppStrings.ConnectPartner.ctaSkip,
                action: { onSkip?() }
            )
        }
    }
}

// MARK: - Preview
#Preview {
    ConnectPartnerView()
        .preferredColorScheme(.dark)
}
