
//
//  WelcomeView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// The first onboarding screen — pixel-perfect recreation of the Closr welcome design.
///
/// Architecture:
/// - Presentation logic lives in `OnboardingViewModel`
/// - All strings come from `AppStrings.Onboarding`
/// - All colours / fonts / spacing use design-system tokens
/// - All interactive elements are built from reusable components
struct WelcomeView: View {

    // MARK: - ViewModel
    @State private var viewModel = OnboardingViewModel()

    // MARK: - Body
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                // ── Background ────────────────────────────────────────────
                AppColors.backgroundPrimary
                    .ignoresSafeArea()

                // ── Content stack ─────────────────────────────────────────
                VStack(spacing: 0) {

                    // App name + divider pill
                    appNameHeader
                        .padding(.top, AppSpacing.xxl)

                    Spacer(minLength: AppSpacing.xl)

                    // Animated logo mark
                    ClosrLogoMark()
                        .opacity(viewModel.logoVisible ? 1 : 0)
                        .scaleEffect(viewModel.logoVisible ? 1 : 0.82)

                    Spacer(minLength: AppSpacing.xl)

                    // Headline + subtitle
                    headlineSection
                        .opacity(viewModel.headlineVisible ? 1 : 0)
                        .offset(y: viewModel.headlineVisible ? 0 : 18)

                    Spacer(minLength: AppSpacing.lg)

                    // CTA buttons
                    buttonSection
                        .opacity(viewModel.buttonsVisible ? 1 : 0)
                        .offset(y: viewModel.buttonsVisible ? 0 : 14)
                        .padding(.bottom, AppSpacing.xxl)
                }
                .padding(.horizontal, AppSpacing.lg)
            }
            // ── Navigation destinations ───────────────────────────────────
            .navigationDestination(for: OnboardingDestination.self) { destination in
                destinationView(for: destination)
            }
            .navigationBarHidden(true)
            .onAppear { viewModel.onAppear() }
        }
    }

    // MARK: - Sub-views

    private var appNameHeader: some View {
        VStack(spacing: AppSpacing.xs) {
            Text(AppStrings.Onboarding.appName)
                .font(AppFonts.headline(size: 22))
                .foregroundStyle(AppColors.textPrimary)
                .tracking(1.5)

            // Brand accent underline pill
            RoundedRectangle(cornerRadius: 2)
                .fill(AppColors.brand)
                .frame(width: 28, height: 2)
        }
    }

    private var headlineSection: some View {
        VStack(spacing: AppSpacing.xs) {

            // "Deeper connection," — bold serif
            Text(AppStrings.Onboarding.headlineTop)
                .font(AppFonts.displayMedium(size: 40))
                .foregroundStyle(AppColors.textPrimary)
                .multilineTextAlignment(.center)
                .lineSpacing(2)

            // "daily." — italic terracotta
            Text(AppStrings.Onboarding.headlineItalic)
                .font(AppFonts.displayItalic(size: 40))
                .foregroundStyle(AppColors.textAccent)
                .multilineTextAlignment(.center)

            // Subtitle
            Text(AppStrings.Onboarding.subtitle)
                .font(AppFonts.bodyRegular(size: 15))
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .padding(.top, AppSpacing.xs)
                .padding(.horizontal, AppSpacing.xs)
        }
    }

    private var buttonSection: some View {
        VStack(spacing: AppSpacing.xs) {
            PrimaryButton(
                title: AppStrings.Onboarding.ctaPrimary,
                action: viewModel.startJourney
            )

            GhostButton(
                title: AppStrings.Onboarding.ctaSecondary,
                action: viewModel.enterInviteCode
            )
        }
    }

    // MARK: - Navigation

    @ViewBuilder
    private func destinationView(for destination: OnboardingDestination) -> some View {
        switch destination {
        case .createAccount:
            // Placeholder — replace with CreateAccountView once built
            PlaceholderDestinationView(title: "Create Account")
        case .inviteCode:
            // Placeholder — replace with InviteCodeView once built
            PlaceholderDestinationView(title: "Enter Invite Code")
        }
    }
}

// MARK: - Placeholder Destination View (remove when real screens exist)

private struct PlaceholderDestinationView: View {
    let title: String
    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()
            Text(title)
                .font(AppFonts.headline())
                .foregroundStyle(AppColors.textPrimary)
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Preview
#Preview {
    WelcomeView()
        .preferredColorScheme(.dark)
}
