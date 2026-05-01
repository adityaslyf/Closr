
//
//  InvitePartnerView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Step 2 of the onboarding flow — invite a partner via email or phone.
///
/// Architecture:
/// - All state & logic in `InvitePartnerViewModel`
/// - Strings from `AppStrings.InvitePartner`
/// - Reusable components: `OnboardingNavBar`, `PrimaryButton`, `GhostButton`
struct InvitePartnerView: View {

    // MARK: - Environment / ViewModel
    @State private var viewModel = InvitePartnerViewModel()
    @Environment(\.dismiss) private var dismiss

    // Callbacks injected from parent navigator
    var onInviteSent: (() -> Void)?
    var onSkip: (() -> Void)?

    // MARK: - Focus
    @FocusState private var isFieldFocused: Bool

    // MARK: - Body
    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Nav bar ───────────────────────────────────────────────
                OnboardingNavBar(totalSteps: 3, currentStep: 2) {
                    dismiss()
                }
                .padding(.horizontal, AppSpacing.lg)
                .padding(.top, AppSpacing.md)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // ── App name + logo ───────────────────────────────
                        appHeader
                            .padding(.top, AppSpacing.xl)

                        // ── Logo mark (smaller scale) ─────────────────────
                        ClosrLogoMark()
                            .scaleEffect(0.55)
                            .frame(height: 145)   // clamp the scaled frame
                            .padding(.top, AppSpacing.xs)

                        // ── Headline ──────────────────────────────────────
                        headlineSection
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 16)

                        // ── Form ──────────────────────────────────────────
                        formSection
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 20)

                        // ── Contact sync row ──────────────────────────────
                        contactSyncRow
                            .padding(.top, AppSpacing.md)
                            .opacity(viewModel.contentVisible ? 1 : 0)

                        // ── CTAs ──────────────────────────────────────────
                        buttonSection
                            .padding(.top, AppSpacing.xl)
                            .padding(.bottom, AppSpacing.xxl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                    }
                    .padding(.horizontal, AppSpacing.lg)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear { viewModel.onAppear() }
        .onTapGesture { isFieldFocused = false }
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

            // "Invite your partner" — mixed weight + colour on one line
            (
                Text(AppStrings.InvitePartner.headlinePrefix)
                    .font(AppFonts.displayMedium(size: 34))
                    .foregroundColor(AppColors.textPrimary)
                +
                Text(AppStrings.InvitePartner.headlineItalic)
                    .font(AppFonts.displayItalic(size: 34))
                    .foregroundColor(AppColors.textAccent)
            )
            .multilineTextAlignment(.center)
            .lineSpacing(2)

            // Subtitle
            Text(AppStrings.InvitePartner.subtitle)
                .font(AppFonts.bodyRegular(size: 15))
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.top, AppSpacing.xxs)
                .padding(.horizontal, AppSpacing.xs)
        }
    }

    private var formSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {

            // Section label
            Text(AppStrings.InvitePartner.sectionLabel)
                .font(.system(size: 11, weight: .semibold, design: .default))
                .foregroundStyle(AppColors.textSecondary)
                .tracking(1.8)

            // Text field
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: AppRadius.md)
                    .fill(AppColors.backgroundCard)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppRadius.md)
                            .stroke(
                                viewModel.hasError
                                    ? AppColors.brand.opacity(0.7)
                                    : (isFieldFocused
                                        ? AppColors.brand.opacity(0.45)
                                        : Color.white.opacity(0.06)),
                                lineWidth: 1
                            )
                    )
                    .frame(height: 56)

                if viewModel.contactInput.isEmpty {
                    Text(AppStrings.InvitePartner.fieldPlaceholder)
                        .font(AppFonts.bodyRegular(size: 16))
                        .foregroundStyle(AppColors.textSecondary.opacity(0.6))
                        .padding(.horizontal, AppSpacing.md)
                }

                TextField("", text: $viewModel.contactInput)
                    .font(AppFonts.bodyRegular(size: 16))
                    .foregroundStyle(AppColors.textPrimary)
                    .tint(AppColors.brand)
                    .padding(.horizontal, AppSpacing.md)
                    .frame(height: 56)
                    .focused($isFieldFocused)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .onChange(of: viewModel.contactInput) { _, _ in
                        if viewModel.hasError { viewModel.hasError = false }
                    }
            }

            // Inline error
            if viewModel.hasError {
                Text(viewModel.errorMessage)
                    .font(AppFonts.label(size: 12))
                    .foregroundStyle(AppColors.brand)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }

    private var contactSyncRow: some View {
        HStack(spacing: AppSpacing.sm) {

            // ── Avatar stack ─────────────────────────────────────────────
            ZStack(alignment: .leading) {
                // Instagram-style icon avatar (second, on top)
                Circle()
                    .fill(AppColors.brand)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "camera.fill")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.white)
                    )
                    .overlay(
                        Circle().stroke(AppColors.backgroundPrimary, lineWidth: 2)
                    )
                    .offset(x: 20)

                // Initials avatar (first, underneath)
                Circle()
                    .fill(AppColors.backgroundSecondary)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Text("JD")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(AppColors.textSecondary)
                    )
                    .overlay(
                        Circle().stroke(AppColors.backgroundPrimary, lineWidth: 2)
                    )
            }
            .frame(width: 56, height: 32)

            // ── Hint text ────────────────────────────────────────────────
            Text(AppStrings.InvitePartner.contactSyncHint)
                .font(AppFonts.bodyRegular(size: 14))
                .foregroundStyle(AppColors.textSecondary)

            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture { viewModel.syncContacts() }
        .pressAnimation()
    }

    private var buttonSection: some View {
        VStack(spacing: AppSpacing.xs) {
            PrimaryButton(
                title: AppStrings.InvitePartner.ctaPrimary,
                action: {
                    viewModel.sendInvitation {
                        onInviteSent?()
                    }
                },
                isLoading: viewModel.isSending
            )

            GhostButton(
                title: AppStrings.InvitePartner.ctaSecondary,
                action: {
                    viewModel.skipForNow {
                        onSkip?()
                    }
                }
            )
        }
    }
}

// MARK: - Preview
#Preview {
    InvitePartnerView()
        .preferredColorScheme(.dark)
}
