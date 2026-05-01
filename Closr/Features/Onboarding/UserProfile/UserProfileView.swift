
//
//  UserProfileView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Step 1 of 3 — user sets up their personal profile.
///
/// Fields:
///   • Avatar photo (PhotosPicker)
///   • Display name
///   • Age (wheel picker sheet)
///   • Relationship length (custom slider)
struct UserProfileView: View {

    // MARK: - ViewModel
    @State private var viewModel = UserProfileViewModel()
    @Environment(\.dismiss) private var dismiss

    // Callback to advance the flow
    var onContinue: (() -> Void)?

    // MARK: - Focus
    @FocusState private var isNameFocused: Bool

    // MARK: - Body
    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Navigation bar ────────────────────────────────────────
                OnboardingNavBar(totalSteps: 3, currentStep: 1) {
                    dismiss()
                }
                .padding(.horizontal, AppSpacing.lg)
                .padding(.top, AppSpacing.md)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // ── Screen title ──────────────────────────────────
                        screenTitle
                            .padding(.top, AppSpacing.xl)

                        // ── Avatar picker ─────────────────────────────────
                        AvatarPickerView(selectedImage: $viewModel.avatarImage)
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .scaleEffect(viewModel.contentVisible ? 1 : 0.9)

                        // ── Name field ────────────────────────────────────
                        nameSection
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 14)

                        // ── Age picker row ────────────────────────────────
                        ageSection
                            .padding(.top, AppSpacing.lg)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 14)

                        // ── Relationship slider ───────────────────────────
                        relationshipSection
                            .padding(.top, AppSpacing.lg)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 18)

                        Spacer(minLength: AppSpacing.xxl)
                    }
                    .padding(.horizontal, AppSpacing.lg)
                }

                // ── Footer: Continue + step indicator ─────────────────────
                footerSection
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.bottom, AppSpacing.xl)
                    .opacity(viewModel.contentVisible ? 1 : 0)
            }
        }
        .navigationBarHidden(true)
        .onAppear { viewModel.onAppear() }
        .onTapGesture { isNameFocused = false }
        // Age picker sheet
        .sheet(isPresented: $viewModel.showAgePicker) {
            agePicker
        }
    }

    // MARK: - Sub-views

    private var screenTitle: some View {
        VStack(spacing: AppSpacing.xs) {
            Text(AppStrings.UserProfile.screenTitle)
                .font(AppFonts.displayMedium(size: 30))
                .foregroundStyle(AppColors.textPrimary)
                .multilineTextAlignment(.center)

            RoundedRectangle(cornerRadius: 2)
                .fill(AppColors.brand)
                .frame(width: 28, height: 2)
        }
    }

    // MARK: - Name

    private var nameSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {

            sectionLabel(AppStrings.UserProfile.nameSectionLabel)

            // Input field
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: AppRadius.md)
                    .fill(AppColors.backgroundCard)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppRadius.md)
                            .stroke(
                                viewModel.hasNameError
                                    ? AppColors.brand.opacity(0.7)
                                    : (isNameFocused
                                        ? AppColors.brand.opacity(0.45)
                                        : Color.white.opacity(0.06)),
                                lineWidth: 1
                            )
                    )
                    .frame(height: 56)

                if viewModel.name.isEmpty {
                    Text(AppStrings.UserProfile.namePlaceholder)
                        .font(AppFonts.bodyRegular(size: 16))
                        .foregroundStyle(AppColors.textSecondary.opacity(0.55))
                        .padding(.horizontal, AppSpacing.md)
                }

                TextField("", text: $viewModel.name)
                    .font(AppFonts.bodyRegular(size: 16))
                    .foregroundStyle(AppColors.textPrimary)
                    .tint(AppColors.brand)
                    .padding(.horizontal, AppSpacing.md)
                    .frame(height: 56)
                    .focused($isNameFocused)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)
                    .onChange(of: viewModel.name) { _, _ in viewModel.onNameChanged() }
            }

            // Inline error or hint
            if viewModel.hasNameError {
                Text(viewModel.nameErrorMessage)
                    .font(AppFonts.label(size: 12))
                    .foregroundStyle(AppColors.brand)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            } else {
                Text(AppStrings.UserProfile.nameHint)
                    .font(AppFonts.label(size: 13))
                    .foregroundStyle(AppColors.textSecondary.opacity(0.7))
                    .lineSpacing(3)
            }
        }
    }

    // MARK: - Age

    private var ageSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {

            sectionLabel(AppStrings.UserProfile.ageSectionLabel)

            Button {
                isNameFocused = false
                viewModel.showAgePicker = true
            } label: {
                HStack {
                    Text("\(viewModel.age) years old")
                        .font(AppFonts.bodyRegular(size: 16))
                        .foregroundStyle(
                            viewModel.age == 25
                                ? AppColors.textSecondary.opacity(0.55)
                                : AppColors.textPrimary
                        )
                        .padding(.leading, AppSpacing.md)

                    Spacer()

                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(AppColors.textSecondary)
                        .padding(.trailing, AppSpacing.md)
                }
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: AppRadius.md)
                        .fill(AppColors.backgroundCard)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppRadius.md)
                                .stroke(Color.white.opacity(0.06), lineWidth: 1)
                        )
                )
            }
            .pressAnimation()

            Text(AppStrings.UserProfile.ageHint)
                .font(AppFonts.label(size: 13))
                .foregroundStyle(AppColors.textSecondary.opacity(0.7))
                .lineSpacing(3)
        }
    }

    // MARK: - Relationship

    private var relationshipSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {

            Text(AppStrings.UserProfile.relationshipLabel)
                .font(AppFonts.bodyRegular(size: 15))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(3)

            RelationshipSlider(value: $viewModel.relationshipLength)
        }
    }

    // MARK: - Footer

    private var footerSection: some View {
        VStack(spacing: AppSpacing.sm) {
            PrimaryButton(
                title: AppStrings.UserProfile.ctaContinue,
                action: { viewModel.onContinue { onContinue?() } },
                isLoading: viewModel.isLoading
            )

            // "Step 1 of 3" with "1 of 3" in white
            (Text("Step ").foregroundColor(AppColors.textSecondary)
             + Text("1 of 3").foregroundColor(AppColors.textPrimary).bold())
                .font(AppFonts.label(size: 13))
        }
    }


    // MARK: - Age Picker Sheet

    private var agePicker: some View {
        NavigationStack {
            ZStack {
                AppColors.backgroundSecondary.ignoresSafeArea()

                VStack(spacing: AppSpacing.lg) {
                    Text("How old are you?")
                        .font(AppFonts.headline(size: 20))
                        .foregroundStyle(AppColors.textPrimary)
                        .padding(.top, AppSpacing.lg)

                    Picker("Age", selection: $viewModel.age) {
                        ForEach(13...100, id: \.self) { age in
                            Text("\(age)")
                                .font(AppFonts.bodyRegular(size: 18))
                                .foregroundStyle(AppColors.textPrimary)
                                .tag(age)
                        }
                    }
                    .pickerStyle(.wheel)
                    .tint(AppColors.brand)

                    PrimaryButton(title: "Done") {
                        viewModel.showAgePicker = false
                    }
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.bottom, AppSpacing.xl)
                }
            }
            .navigationBarHidden(true)
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
            .presentationBackground(AppColors.backgroundSecondary)
        }
    }

    // MARK: - Helpers

    private func sectionLabel(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 11, weight: .semibold))
            .foregroundStyle(AppColors.textSecondary)
            .tracking(1.8)
    }
}

// MARK: - Preview
#Preview {
    UserProfileView()
        .preferredColorScheme(.dark)
}
