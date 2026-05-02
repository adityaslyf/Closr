
//
//  RelationshipStatusView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

struct RelationshipStatusView: View {

    @State private var viewModel = RelationshipStatusViewModel()
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
                        
                        Text("How do you define your relationship with \(viewModel.partnerName)?")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(AppColors.textPrimary)
                            .padding(.top, AppSpacing.lg)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)

                        VStack(spacing: AppSpacing.sm) {
                            ForEach(RelationshipStatusOption.allCases) { option in
                                optionRow(for: option)
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
                    title: "Next",
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
                        .fill(AppColors.buttonBackground)
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

    private func optionRow(for option: RelationshipStatusOption) -> some View {
        let isSelected = viewModel.selectedStatus == option

        return Button {
            viewModel.select(option)
        } label: {
            HStack(spacing: AppSpacing.md) {
                // Radio circle
                if isSelected {
                    Image(systemName: "record.circle")
                        .foregroundStyle(AppColors.brand)
                        .font(.system(size: 20))
                } else {
                    Circle()
                        .stroke(AppColors.borderActive, lineWidth: 1.5)
                        .frame(width: 20, height: 20)
                }

                Text(option.rawValue)
                    .font(AppFonts.bodyMedium(size: 16))
                    .foregroundStyle(isSelected ? AppColors.textPrimary : AppColors.textSecondary)
                
                Spacer()

                // Large decorative icon
                Image(systemName: option.icon)
                    .font(.system(size: 32))
                    .foregroundStyle(AppColors.brand.opacity(isSelected ? 0.8 : 0.3))
            }
            .padding(.horizontal, AppSpacing.lg)
            .frame(height: 72)
            .background(
                RoundedRectangle(cornerRadius: AppRadius.md)
                    .fill(isSelected ? AppColors.brand.opacity(0.1) : AppColors.backgroundCard)
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.md)
                    .stroke(isSelected ? AppColors.brand : AppColors.border, lineWidth: 1)
            )
        }
        .pressAnimation()
    }
}

#Preview {
    RelationshipStatusView()
        
}
