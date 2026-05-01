
//
//  PaywallView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Premium subscription paywall screen.
/// Presents features, monthly/annual plan selection, and trial CTA.
struct PaywallView: View {

    @State private var viewModel = PaywallViewModel()
    @Environment(\.dismiss) private var dismiss

    var onContinue: (() -> Void)?

    private let teal = Color(hex: "#5ECFB1")

    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Optional Sheet Handle / Back Bar ──────────────────────
                // If pushed in NavStack, this acts as a back button.
                backBar
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.top, AppSpacing.md)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {

                        // ── Badge ─────────────────────────────────────────
                        TagBadge(
                            title: "Premium",
                            foreground: teal,
                            borderColor: teal.opacity(0.5),
                            background: teal.opacity(0.1)
                        )
                        .padding(.top, AppSpacing.lg)
                        .opacity(viewModel.contentVisible ? 1 : 0)

                        // ── Headline & Subtitle ───────────────────────────
                        headerSection
                            .padding(.top, AppSpacing.md)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)
                            .animation(.easeOut(duration: 0.4).delay(0.05), value: viewModel.contentVisible)

                        // ── Feature Bullets ───────────────────────────────
                        featuresSection
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 16)
                            .animation(.easeOut(duration: 0.4).delay(0.1), value: viewModel.contentVisible)

                        // ── Plan Cards ────────────────────────────────────
                        plansSection
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 20)
                            .animation(.easeOut(duration: 0.4).delay(0.15), value: viewModel.contentVisible)

                        Spacer(minLength: AppSpacing.lg)
                    }
                    .padding(.horizontal, AppSpacing.lg)
                }

                // ── Sticky Footer ─────────────────────────────────────────
                footerSection
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.bottom, AppSpacing.xl)
                    .opacity(viewModel.contentVisible ? 1 : 0)
                    .animation(.easeIn(duration: 0.3).delay(0.2), value: viewModel.contentVisible)
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

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("try free for 7 days")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)

            Text("then $6.99/mo or $49.99/yr. cancel\nanytime.")
                .font(AppFonts.bodyRegular(size: 16))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
        }
    }

    private var featuresSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            PaywallFeatureRow(text: "daily AI questions personalized to you")
            PaywallFeatureRow(text: "connection score + intimacy section")
            PaywallFeatureRow(text: "real-world missions & dares")
            PaywallFeatureRow(text: "memory timeline — unlimited photos")
            PaywallFeatureRow(text: "weekly relationship pulse report")
        }
    }

    private var plansSection: some View {
        HStack(spacing: AppSpacing.sm) {
            SubscriptionPlanCard(
                title: "monthly",
                price: "$6.99",
                subtitle: "per month",
                badgeText: nil,
                isSelected: viewModel.selectedPlan == .monthly,
                action: { viewModel.selectPlan(.monthly) }
            )

            SubscriptionPlanCard(
                title: "annual",
                price: "$49.99",
                subtitle: "$4.17/mo",
                badgeText: "save 40%",
                isSelected: viewModel.selectedPlan == .annual,
                action: { viewModel.selectPlan(.annual) }
            )
        }
    }

    private var footerSection: some View {
        VStack(spacing: AppSpacing.md) {
            PrimaryButton(
                title: viewModel.ctaTitle,
                action: {
                    viewModel.startFreeTrial {
                        onContinue?()
                    }
                },
                isLoading: viewModel.isLoading
            )

            Text("no charge until day 8 • cancel anytime")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(AppColors.textSecondary)
        }
    }
}

// MARK: - Preview
#Preview {
    PaywallView()
        .preferredColorScheme(.dark)
}
