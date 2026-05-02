
//
//  RelationshipLengthView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

struct RelationshipLengthView: View {

    @State private var viewModel = RelationshipLengthViewModel()
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
                        
                        Text("How long have you been together for as a couple?")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(AppColors.textPrimary)
                            .padding(.top, AppSpacing.lg)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)

                        Text("We'll add this to your relationship timeline and send you reminders on your anniversary.")
                            .font(AppFonts.bodyRegular(size: 15))
                            .foregroundStyle(AppColors.textSecondary)
                            .padding(.top, AppSpacing.sm)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)

                        VStack(alignment: .leading, spacing: AppSpacing.xs) {
                            Text("We've been together since")
                                .font(AppFonts.label(size: 13))
                                .foregroundStyle(AppColors.textSecondary)

                            Button {
                                viewModel.showDatePicker = true
                            } label: {
                                HStack {
                                    if let date = viewModel.relationshipDate {
                                        Text(date.formatted(date: .long, time: .omitted))
                                            .font(AppFonts.bodyRegular(size: 16))
                                            .foregroundStyle(AppColors.textPrimary)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(AppColors.brand)
                                            .font(.system(size: 20))
                                    } else {
                                        Text("Select date")
                                            .font(AppFonts.bodyRegular(size: 16))
                                            .foregroundStyle(AppColors.textSecondary.opacity(0.5))
                                        Spacer()
                                        Image(systemName: "calendar")
                                            .foregroundStyle(AppColors.textSecondary)
                                    }
                                }
                                .padding(.horizontal, AppSpacing.md)
                                .frame(height: 56)
                                .background(
                                    RoundedRectangle(cornerRadius: AppRadius.md)
                                        .fill(AppColors.backgroundCard)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppRadius.md)
                                        .stroke(Color.white.opacity(0.06), lineWidth: 1)
                                )
                            }
                            .pressAnimation()
                        }
                        .padding(.top, AppSpacing.xl)
                        .opacity(viewModel.contentVisible ? 1 : 0)
                        .offset(y: viewModel.contentVisible ? 0 : 16)

                        if viewModel.relationshipDate != nil {
                            dynamicInsightSection
                                .padding(.top, AppSpacing.xxl)
                                .transition(.asymmetric(
                                    insertion: .move(edge: .bottom).combined(with: .opacity),
                                    removal: .opacity
                                ))
                        }

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
        .sheet(isPresented: $viewModel.showDatePicker) {
            datePickerSheet
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

    private var dynamicInsightSection: some View {
        VStack(spacing: AppSpacing.sm) {
            Image(systemName: "leaf.fill")
                .font(.system(size: 40))
                .foregroundStyle(AppColors.brand)
                .padding(.bottom, AppSpacing.sm)

            Text(viewModel.dynamicHeadline)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)
                .multilineTextAlignment(.center)

            Text(viewModel.dynamicSubtitle)
                .font(AppFonts.bodyRegular(size: 14))
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .lineSpacing(2)
        }
        .frame(maxWidth: .infinity)
    }

    private var datePickerSheet: some View {
        NavigationStack {
            ZStack {
                AppColors.backgroundSecondary.ignoresSafeArea()

                VStack(spacing: AppSpacing.lg) {
                    Text("When did you get together?")
                        .font(AppFonts.headline(size: 20))
                        .foregroundStyle(AppColors.textPrimary)
                        .padding(.top, AppSpacing.lg)

                    DatePicker(
                        "",
                        selection: Binding(
                            get: { viewModel.relationshipDate ?? Date() },
                            set: { viewModel.relationshipDate = $0 }
                        ),
                        in: ...Date(),
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .tint(AppColors.brand)
                    .environment(\.colorScheme, .dark)
                    .padding()

                    PrimaryButton(title: "Done") {
                        viewModel.showDatePicker = false
                    }
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.bottom, AppSpacing.xl)
                }
            }
            .navigationBarHidden(true)
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
            .presentationBackground(AppColors.backgroundSecondary)
        }
    }
}

#Preview {
    RelationshipLengthView()
        .preferredColorScheme(.dark)
}
