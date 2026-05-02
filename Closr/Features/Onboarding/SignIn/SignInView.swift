
//
//  SignInView.swift
//  Closr
//
//  Created by Aditya Varshney on 03/05/26.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @State private var viewModel = SignInViewModel()
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

                Spacer()

                // Headline Content
                VStack(spacing: AppSpacing.sm) {
                    Image(systemName: "person.crop.circle.badge.checkmark")
                        .font(.system(size: 64))
                        .foregroundStyle(AppColors.brand)
                        .padding(.bottom, AppSpacing.sm)
                        .opacity(viewModel.contentVisible ? 1 : 0)
                        .offset(y: viewModel.contentVisible ? 0 : 12)

                    Text("Create your account")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(AppColors.textPrimary)
                        .opacity(viewModel.contentVisible ? 1 : 0)
                        .offset(y: viewModel.contentVisible ? 0 : 12)

                    Text("Save your progress and securely connect with your partner.")
                        .font(AppFonts.bodyRegular(size: 15))
                        .foregroundStyle(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)
                        .opacity(viewModel.contentVisible ? 1 : 0)
                        .offset(y: viewModel.contentVisible ? 0 : 12)
                }
                .padding(.horizontal, AppSpacing.xl)

                Spacer()

                // Sign In Buttons
                VStack(spacing: AppSpacing.md) {
                    // Native Apple Sign In Button
                    SignInWithAppleButton(.continue) { request in
                        request.requestedScopes = [.fullName, .email]
                    } onCompletion: { result in
                        switch result {
                        case .success(let authorization):
                            // TODO: Handle the Apple ID credential and authenticate with your backend
                            onContinue?()
                        case .failure(let error):
                            print("Apple Sign In failed: \(error.localizedDescription)")
                        }
                    }
                    .signInWithAppleButtonStyle(.white)
                    .frame(height: 56)
                    .cornerRadius(28)

                    // Google Sign In Button
                    Button {
                        onContinue?()
                    } label: {
                        HStack(spacing: 8) {
                            // Using a G-like layout. If you have a Google asset later, it goes here.
                            Text("G")
                                .font(.system(size: 18, weight: .bold))
                            Text("Continue with Google")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(AppColors.backgroundCard)
                        .cornerRadius(28)
                        .overlay(
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(AppColors.borderActive, lineWidth: 1)
                        )
                    }
                }
                .padding(.horizontal, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xl)
                .opacity(viewModel.contentVisible ? 1 : 0)
                .offset(y: viewModel.contentVisible ? 0 : 20)
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

            Button {
                onContinue?()
            } label: {
                Text("Skip")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(AppColors.textSecondary)
            }
            .pressAnimation()
        }
    }
}

#Preview {
    SignInView()
        
}
