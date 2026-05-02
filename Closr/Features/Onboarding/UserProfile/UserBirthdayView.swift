
//
//  UserBirthdayView.swift
//  Closr
//
//  Created by Aditya Varshney on 03/05/26.
//

import SwiftUI

struct UserBirthdayView: View {
    @State private var viewModel = UserBirthdayViewModel()
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
                    VStack(alignment: .center, spacing: 0) {
                        
                        Text("When is your birthday?")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(AppColors.textPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, AppSpacing.lg)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)

                        Text("This helps us tailor your insights.")
                            .font(AppFonts.bodyRegular(size: 15))
                            .foregroundStyle(AppColors.textSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, AppSpacing.sm)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)

                        DatePicker("", selection: $viewModel.birthday, displayedComponents: .date)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .colorScheme(.dark)
                            .padding(.top, AppSpacing.xl)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 16)
                            .frame(maxWidth: .infinity)

                        Spacer(minLength: AppSpacing.lg)
                    }
                    .padding(.horizontal, AppSpacing.lg)
                }

                PrimaryButton(
                    title: "Next",
                    action: { onContinue?() }
                )
                .padding(.horizontal, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xl)
                .opacity(viewModel.contentVisible ? 1 : 0)
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
}

#Preview {
    UserBirthdayView()
        .preferredColorScheme(.dark)
}
