
//
//  GenderView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

struct GenderView: View {

    @State private var viewModel = GenderViewModel()
    @Environment(\.dismiss) private var dismiss

    var onContinue: (() -> Void)?

    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()

            VStack(spacing: 0) {
                // Back button
                backBar
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.top, AppSpacing.md)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text("What's your gender?")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(AppColors.textPrimary)
                            .padding(.top, AppSpacing.lg)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)

                        Text("We use this to personalize your experience.")
                            .font(AppFonts.bodyRegular(size: 15))
                            .foregroundStyle(AppColors.textSecondary)
                            .padding(.top, AppSpacing.sm)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)

                        VStack(spacing: AppSpacing.sm) {
                            ForEach(GenderOption.allCases) { option in
                                genderRow(for: option)
                            }
                        }
                        .padding(.top, AppSpacing.xl)
                        .opacity(viewModel.contentVisible ? 1 : 0)
                        .offset(y: viewModel.contentVisible ? 0 : 16)

                        Spacer(minLength: AppSpacing.lg)
                    }
                    .padding(.horizontal, AppSpacing.lg)
                }

                PrimaryButton(
                    title: "continue",
                    action: { onContinue?() }
                )
                .opacity(viewModel.canContinue ? 1 : 0.4)
                .disabled(!viewModel.canContinue)
                .animation(.easeInOut(duration: 0.2), value: viewModel.canContinue)
                .padding(.horizontal, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xl)
            }
        }
        .navigationBarHidden(true)
        .onAppear { viewModel.onAppear() }
    }

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

    private func genderRow(for option: GenderOption) -> some View {
        let isSelected = viewModel.selectedGender == option

        return Button {
            viewModel.select(option)
        } label: {
            HStack {
                Text(option.rawValue)
                    .font(AppFonts.bodyMedium(size: 16))
                    .foregroundStyle(isSelected ? AppColors.textPrimary : AppColors.textSecondary)
                
                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(AppColors.brand)
                        .font(.system(size: 20))
                } else {
                    Circle()
                        .stroke(Color.white.opacity(0.12), lineWidth: 1.5)
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.horizontal, AppSpacing.md)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: AppRadius.md)
                    .fill(isSelected ? AppColors.brand.opacity(0.1) : AppColors.backgroundCard)
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.md)
                    .stroke(isSelected ? AppColors.brand : Color.white.opacity(0.06), lineWidth: 1)
            )
        }
        .pressAnimation()
    }
}

#Preview {
    GenderView()
        .preferredColorScheme(.dark)
}
