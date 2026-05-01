
//
//  ConnectPartnerView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Step 3 of the onboarding flow.
/// No logo — content fits a single screen.
/// Contextual panel slides in when a card is selected; ScrollView
/// activates only then to accommodate the extra height.
struct ConnectPartnerView: View {

    // MARK: - ViewModel
    @State private var viewModel = ConnectPartnerViewModel()
    @Environment(\.dismiss) private var dismiss

    var onConnected: (() -> Void)?
    var onSkip: (() -> Void)?

    @FocusState private var isCodeFieldFocused: Bool
    @State private var codeCopied = false

    // MARK: - Body
    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Nav bar ───────────────────────────────────────────────
                OnboardingNavBar(totalSteps: 3, currentStep: 3) { dismiss() }
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.top, AppSpacing.md)

                // Scrollable content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // Headline
                        headlineSection
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 14)

                        // Option cards
                        optionCards
                            .padding(.top, AppSpacing.lg)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 18)

                        // Contextual input panel (slides in)
                        if viewModel.selectedMode != nil {
                            contextPanel
                                .padding(.top, AppSpacing.md)
                                .transition(.asymmetric(
                                    insertion: .move(edge: .bottom).combined(with: .opacity),
                                    removal:   .opacity
                                ))
                        }

                        Spacer(minLength: AppSpacing.lg)
                    }
                    .padding(.horizontal, AppSpacing.lg)
                    .animation(.easeInOut(duration: 0.35), value: viewModel.selectedMode)
                    .frame(minHeight: UIScreen.main.bounds.height - 200)
                }

                // ── Sticky footer ─────────────────────────────────────────
                buttonSection
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.bottom, AppSpacing.xl)
                    .opacity(viewModel.contentVisible ? 1 : 0)
            }
        }
        .navigationBarHidden(true)
        .onAppear { viewModel.onAppear() }
        .onTapGesture { isCodeFieldFocused = false }
    }

    // MARK: - Headline

    private var headlineSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            (
                Text(AppStrings.ConnectPartner.headlinePrefix)
                    .font(AppFonts.displayMedium(size: 30))
                    .foregroundColor(AppColors.textPrimary)
                +
                Text(AppStrings.ConnectPartner.headlineItalic)
                    .font(AppFonts.displayItalic(size: 30))
                    .foregroundColor(AppColors.textAccent)
            )
            .lineSpacing(2)

            Text(AppStrings.ConnectPartner.subtitle)
                .font(AppFonts.bodyRegular(size: 15))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
                .padding(.top, AppSpacing.xxs)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Option Cards

    private var optionCards: some View {
        VStack(spacing: AppSpacing.sm) {
            ConnectionOptionCard(
                icon:       "key.fill",
                title:      AppStrings.ConnectPartner.enterCardTitle,
                subtitle:   AppStrings.ConnectPartner.enterCardSubtitle,
                isSelected: viewModel.selectedMode == .enterCode,
                action:     { viewModel.select(mode: .enterCode) }
            )

            orDivider

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
            Rectangle().fill(Color.white.opacity(0.1)).frame(height: 1)
            Text("OR")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)
                .tracking(1.5)
            Rectangle().fill(Color.white.opacity(0.1)).frame(height: 1)
        }
    }

    // MARK: - Context Panel

    @ViewBuilder
    private var contextPanel: some View {
        switch viewModel.selectedMode {
        case .enterCode:  enterCodePanel
        case .shareCode:  shareCodePanel
        case .none:       EmptyView()
        }
    }

    private var enterCodePanel: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text(AppStrings.ConnectPartner.enterSectionLabel)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)
                .tracking(1.8)

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
                    .onChange(of: viewModel.enteredCode) { _, _ in viewModel.hasCodeError = false }
            }

            if viewModel.hasCodeError {
                Text(viewModel.codeErrorMessage)
                    .font(AppFonts.label(size: 12))
                    .foregroundStyle(AppColors.brand)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }

    private var shareCodePanel: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text(AppStrings.ConnectPartner.shareSectionLabel)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)
                .tracking(1.8)

            HStack(spacing: AppSpacing.sm) {
                Text(viewModel.shareCode)
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundStyle(AppColors.textPrimary)
                    .tracking(2)
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
                        Text(codeCopied ? AppStrings.ConnectPartner.shareCopied
                                        : AppStrings.ConnectPartner.shareCopyButton)
                            .font(AppFonts.bodyMedium(size: 14))
                    }
                    .foregroundStyle(codeCopied ? AppColors.brand : AppColors.textPrimary)
                    .padding(.horizontal, AppSpacing.md)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: AppRadius.md)
                            .fill(codeCopied ? AppColors.brand.opacity(0.12)
                                             : Color.white.opacity(0.08))
                    )
                }
                .pressAnimation()
            }

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

    // MARK: - Footer Buttons

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
