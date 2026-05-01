
//
//  UserProfileView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

/// Step 1 of 3 — user sets up their personal profile.
/// All content fits a single screen without scrolling:
///   • "Your profile" title + brand underline
///   • Avatar picker (80pt circle)
///   • Name field
///   • Age picker row
///   • Relationship slider
///   • Sticky Continue + step indicator footer
struct UserProfileView: View {

    // MARK: - ViewModel
    @State private var viewModel = UserProfileViewModel()
    @Environment(\.dismiss) private var dismiss

    var onContinue: (() -> Void)?

    @FocusState private var isNameFocused: Bool

    // MARK: - Body
    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Nav bar ───────────────────────────────────────────────
                OnboardingNavBar(totalSteps: 3, currentStep: 1) { dismiss() }
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.top, AppSpacing.md)

                // ── Scrollable body ───────────────────────────────────────
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // Title
                        screenTitle
                            .padding(.top, AppSpacing.lg)

                        // Avatar
                        AvatarPickerView(selectedImage: $viewModel.avatarImage)
                            .padding(.top, AppSpacing.md)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .scaleEffect(viewModel.contentVisible ? 1 : 0.88)
                            .animation(.spring(response: 0.45, dampingFraction: 0.7), value: viewModel.contentVisible)

                        // Name field
                        nameSection
                            .padding(.top, AppSpacing.lg)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)
                            .animation(.easeOut(duration: 0.4).delay(0.1), value: viewModel.contentVisible)

                        // Age row
                        ageSection
                            .padding(.top, AppSpacing.md)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)
                            .animation(.easeOut(duration: 0.4).delay(0.15), value: viewModel.contentVisible)

                        // Relationship slider
                        relationshipSection
                            .padding(.top, AppSpacing.md)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)
                            .animation(.easeOut(duration: 0.4).delay(0.2), value: viewModel.contentVisible)

                        Spacer(minLength: AppSpacing.sm)
                    }
                    .padding(.horizontal, AppSpacing.lg)
                }

                // ── Sticky footer ─────────────────────────────────────────
                footerSection
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.bottom, AppSpacing.xl)
                    .opacity(viewModel.contentVisible ? 1 : 0)
            }
        }
        .navigationBarHidden(true)
        .onAppear { viewModel.onAppear() }
        .onTapGesture { isNameFocused = false }
        .sheet(isPresented: $viewModel.showAgePicker) { agePicker }
    }

    // MARK: - Title

    private var screenTitle: some View {
        VStack(spacing: 6) {
            Text(AppStrings.UserProfile.screenTitle)
                .font(AppFonts.displayMedium(size: 26))
                .foregroundStyle(AppColors.textPrimary)
                .multilineTextAlignment(.center)

            RoundedRectangle(cornerRadius: 2)
                .fill(AppColors.brand)
                .frame(width: 24, height: 2)
        }
    }

    // MARK: - Name

    private var nameSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {

            sectionLabel(AppStrings.UserProfile.nameSectionLabel)

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
                    .frame(height: 52)

                if viewModel.name.isEmpty {
                    Text(AppStrings.UserProfile.namePlaceholder)
                        .font(AppFonts.bodyRegular(size: 15))
                        .foregroundStyle(AppColors.textSecondary.opacity(0.5))
                        .padding(.horizontal, AppSpacing.md)
                }

                TextField("", text: $viewModel.name)
                    .font(AppFonts.bodyRegular(size: 15))
                    .foregroundStyle(AppColors.textPrimary)
                    .tint(AppColors.brand)
                    .padding(.horizontal, AppSpacing.md)
                    .frame(height: 52)
                    .focused($isNameFocused)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)
                    .onChange(of: viewModel.name) { _, _ in viewModel.onNameChanged() }
            }

            // Error or compact hint
            Group {
                if viewModel.hasNameError {
                    Text(viewModel.nameErrorMessage)
                        .foregroundStyle(AppColors.brand)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                } else {
                    Text(AppStrings.UserProfile.nameHint)
                        .foregroundStyle(AppColors.textSecondary.opacity(0.65))
                }
            }
            .font(AppFonts.label(size: 12))
            .lineSpacing(2)
        }
    }

    // MARK: - Age

    private var ageSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {

            sectionLabel(AppStrings.UserProfile.ageSectionLabel)

            Button {
                isNameFocused = false
                viewModel.showAgePicker = true
            } label: {
                HStack {
                    Text("\(viewModel.age) years old")
                        .font(AppFonts.bodyRegular(size: 15))
                        .foregroundStyle(
                            viewModel.age == 25
                                ? AppColors.textSecondary.opacity(0.5)
                                : AppColors.textPrimary
                        )
                        .padding(.leading, AppSpacing.md)

                    Spacer()

                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(AppColors.textSecondary)
                        .padding(.trailing, AppSpacing.md)
                }
                .frame(height: 52)
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
        }
    }

    // MARK: - Relationship

    private var relationshipSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text(AppStrings.UserProfile.relationshipLabel)
                .font(AppFonts.bodyRegular(size: 14))
                .foregroundStyle(AppColors.textSecondary)

            RelationshipSlider(value: $viewModel.relationshipLength)
        }
    }

    // MARK: - Footer

    private var footerSection: some View {
        VStack(spacing: AppSpacing.xs) {
            PrimaryButton(
                title: AppStrings.UserProfile.ctaContinue,
                action: { viewModel.onContinue { onContinue?() } },
                isLoading: viewModel.isLoading
            )

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
            .font(.system(size: 10, weight: .semibold))
            .foregroundStyle(AppColors.textSecondary)
            .tracking(1.8)
    }
}

// MARK: - Preview
#Preview {
    UserProfileView()
        .preferredColorScheme(.dark)
}
