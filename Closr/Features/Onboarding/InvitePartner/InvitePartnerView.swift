
//
//  InvitePartnerView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Step 2 of the onboarding flow — invite a partner via email or phone.
/// Logo removed; buttons are a sticky footer so everything fits one screen.
struct InvitePartnerView: View {

    // MARK: - ViewModel
    @State private var viewModel = InvitePartnerViewModel()
    @Environment(\.dismiss) private var dismiss

    var onInviteSent: (() -> Void)?
    var onSkip: (() -> Void)?

    @FocusState private var isFieldFocused: Bool

    // MARK: - Body
    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Nav bar ───────────────────────────────────────────────
                OnboardingNavBar(totalSteps: 3, currentStep: 2) { dismiss() }
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.top, AppSpacing.md)

                // ── Scrollable content ────────────────────────────────────
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        headlineSection
                            .padding(.top, AppSpacing.xxl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 16)

                        formSection
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 20)

                        contactSyncRow
                            .padding(.top, AppSpacing.md)
                            .opacity(viewModel.contentVisible ? 1 : 0)

                        Spacer(minLength: AppSpacing.lg)
                    }
                    .padding(.horizontal, AppSpacing.lg)
                    .frame(minHeight: UIScreen.main.bounds.height - 240)
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
        .onTapGesture { isFieldFocused = false }
    }

    // MARK: - Headline

    private var headlineSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            (
                Text(AppStrings.InvitePartner.headlinePrefix)
                    .font(AppFonts.displayMedium(size: 34))
                    .foregroundColor(AppColors.textPrimary)
                +
                Text(AppStrings.InvitePartner.headlineItalic)
                    .font(AppFonts.displayItalic(size: 34))
                    .foregroundColor(AppColors.textAccent)
            )
            .lineSpacing(2)

            Text(AppStrings.InvitePartner.subtitle)
                .font(AppFonts.bodyRegular(size: 15))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
                .padding(.top, AppSpacing.xxs)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Form

    private var formSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {

            Text(AppStrings.InvitePartner.sectionLabel)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)
                .tracking(1.8)

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

            if viewModel.hasError {
                Text(viewModel.errorMessage)
                    .font(AppFonts.label(size: 12))
                    .foregroundStyle(AppColors.brand)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }

    // MARK: - Contact Sync

    private var contactSyncRow: some View {
        HStack(spacing: AppSpacing.sm) {
            ZStack(alignment: .leading) {
                Circle()
                    .fill(AppColors.brand)
                    .frame(width: 32, height: 32)
                    .overlay(Image(systemName: "camera.fill")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.white))
                    .overlay(Circle().stroke(AppColors.backgroundPrimary, lineWidth: 2))
                    .offset(x: 20)

                Circle()
                    .fill(AppColors.backgroundSecondary)
                    .frame(width: 32, height: 32)
                    .overlay(Text("JD")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(AppColors.textSecondary))
                    .overlay(Circle().stroke(AppColors.backgroundPrimary, lineWidth: 2))
            }
            .frame(width: 56, height: 32)

            Text(AppStrings.InvitePartner.contactSyncHint)
                .font(AppFonts.bodyRegular(size: 14))
                .foregroundStyle(AppColors.textSecondary)

            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture { viewModel.syncContacts() }
        .pressAnimation()
    }

    // MARK: - Footer Buttons

    private var buttonSection: some View {
        VStack(spacing: AppSpacing.xs) {
            PrimaryButton(
                title: AppStrings.InvitePartner.ctaPrimary,
                action: { viewModel.sendInvitation { onInviteSent?() } },
                isLoading: viewModel.isSending
            )

            GhostButton(
                title: AppStrings.InvitePartner.ctaSecondary,
                action: { viewModel.skipForNow { onSkip?() } }
            )
        }
    }
}

// MARK: - Preview
#Preview {
    InvitePartnerView()
        .preferredColorScheme(.dark)
}
