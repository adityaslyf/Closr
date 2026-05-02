
//
//  PartnerNameView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

struct PartnerNameView: View {

    @State private var viewModel = PartnerNameViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isInputFocused: Bool

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
                        
                        Text("What's your partner's name?")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(AppColors.textPrimary)
                            .padding(.top, AppSpacing.lg)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)

                        Text("We'll use this to personalize your shared space.")
                            .font(AppFonts.bodyRegular(size: 15))
                            .foregroundStyle(AppColors.textSecondary)
                            .padding(.top, AppSpacing.sm)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)

                        TextField("Partner's name", text: $viewModel.partnerName)
                            .font(AppFonts.bodyRegular(size: 16))
                            .foregroundStyle(AppColors.textPrimary)
                            .tint(AppColors.brand)
                            .padding(.horizontal, AppSpacing.md)
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: AppRadius.md)
                                    .fill(AppColors.backgroundCard)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: AppRadius.md)
                                    .stroke(isInputFocused ? AppColors.brand : Color.white.opacity(0.06), lineWidth: 1)
                            )
                            .focused($isInputFocused)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.words)
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
        .onAppear {
            viewModel.onAppear()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isInputFocused = true
            }
        }
        .onTapGesture {
            isInputFocused = false
        }
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
}

#Preview {
    PartnerNameView()
        .preferredColorScheme(.dark)
}
