
//
//  ValuePropositionView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI

struct ValuePropositionView: View {

    @State private var viewModel = ValuePropositionViewModel()
    @Environment(\.dismiss) private var dismiss

    var onContinue: (() -> Void)?

    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()

            // Decorative background elements
            sparkles

            VStack(spacing: 0) {
                // Back button
                backBar
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.top, AppSpacing.md)

                VStack(alignment: .center, spacing: 0) {
                        
                        Text("Closr helps couples stay\nin love")
                            .font(.system(size: 26, weight: .bold)) // Reduced from 28
                            .foregroundStyle(AppColors.textPrimary)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .minimumScaleFactor(0.6) // Allows the text to shrink instead of truncating
                            .lineSpacing(2)
                            .padding(.top, AppSpacing.lg)
                            .opacity(viewModel.contentVisible ? 1 : 0)
                            .offset(y: viewModel.contentVisible ? 0 : 12)
                            .layoutPriority(1) // Ensure it doesn't get squished by the GeometryReader

                        // Cards Container
                        GeometryReader { proxy in
                            let width = proxy.size.width
                            ZStack(alignment: .top) {
                                
                                // LEFT CARD
                                withoutCard(screenWidth: width)
                                    .frame(width: width * 0.56) // Exactly 56% to allow more visible area
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .offset(y: viewModel.cardsVisible ? 40 : 100)
                                    .opacity(viewModel.cardsVisible ? 1 : 0)
                                
                                // RIGHT CARD
                                withCard
                                    .frame(width: width * 0.56) // Exactly 56%
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .offset(y: viewModel.cardsVisible ? 0 : 60)
                                    .opacity(viewModel.cardsVisible ? 1 : 0)
                                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: -10, y: 10)
                            }
                        }
                        .frame(height: 500) // Fixed height for the overlapping cards
                        .padding(.top, AppSpacing.xl)
                        .padding(.horizontal, AppSpacing.md)

                        Spacer(minLength: AppSpacing.lg)
                    }

                Button {
                    onContinue?()
                } label: {
                    HStack {
                        Text("Next")
                            .font(.system(size: 16, weight: .bold))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .bold))
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.white)
                    .cornerRadius(28)
                }
                .padding(.horizontal, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xl)
                .opacity(viewModel.contentVisible ? 1 : 0)
            }
        }
        .navigationBarHidden(true)
        .onAppear { viewModel.onAppear() }
    }

    private var sparkles: some View {
        ZStack {
            Image(systemName: "sparkles")
                .font(.system(size: 32))
                .foregroundStyle(AppColors.brand)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.leading, 40)
                .padding(.top, 180)
                .opacity(viewModel.contentVisible ? 0.8 : 0)
                .animation(.easeInOut(duration: 1).delay(0.3), value: viewModel.contentVisible)
            
            Image(systemName: "sparkle")
                .font(.system(size: 24))
                .foregroundStyle(AppColors.brand)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.trailing, 50)
                .padding(.top, 120)
                .opacity(viewModel.contentVisible ? 0.6 : 0)
                .animation(.easeInOut(duration: 1).delay(0.5), value: viewModel.contentVisible)
        }
        .ignoresSafeArea()
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

    private func withoutCard(screenWidth: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Without Closr")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(AppColors.textSecondary)
                .padding(.bottom, 4)

            negativeRow("Stuck in the day to day routine")
            negativeRow("Feeling detached")
            negativeRow("Avoiding deeper conversations")
            negativeRow("Not sure what steps to take to improve your relationship")

            Spacer(minLength: 20)
            
            // Placeholder for sad couple illustration
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "cloud.rain.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(AppColors.textSecondary)
                        .padding(.bottom, 4)
                    Image(systemName: "figure.stand")
                        .font(.system(size: 40))
                        .foregroundStyle(AppColors.textSecondary)
                }
                Spacer()
            }
            .padding(.bottom, AppSpacing.sm)
        }
        .padding(AppSpacing.md)
        // Since both cards are 56% width, they overlap by 12%.
        // We add 14% trailing padding so text wraps cleanly before the overlap.
        .padding(.trailing, screenWidth * 0.14) 
        .frame(height: 460)
        .background(
            RoundedRectangle(cornerRadius: AppRadius.lg)
                .fill(AppColors.backgroundSecondary)
        )
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.lg)
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
    }

    private var withCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("With Closr")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)
                .padding(.bottom, 4)

            positiveRow("Getting to know each other on a deeper level")
            positiveRow("Feeling connected every day")
            positiveRow("Talking openly about sex, finances, conflict")
            positiveRow("Reaching your relationship goals together")

            Spacer(minLength: 20)
            
            // Placeholder for happy couple illustration
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(AppColors.brand)
                        .padding(.bottom, 2)
                        .offset(x: 20, y: -10)
                    
                    Image(systemName: "figure.2.arms.open")
                        .font(.system(size: 60))
                        .foregroundStyle(AppColors.brand)
                }
                Spacer()
            }
            .padding(.bottom, AppSpacing.sm)
        }
        .padding(AppSpacing.md)
        .frame(height: 460)
        .background(
            ZStack {
                // Solid base to prevent the underlying card from bleeding through
                RoundedRectangle(cornerRadius: AppRadius.lg)
                    .fill(AppColors.backgroundPrimary)
                // Soft brand tint overlaid on top
                RoundedRectangle(cornerRadius: AppRadius.lg)
                    .fill(AppColors.brand.opacity(0.15))
            }
        )
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.lg)
                .stroke(AppColors.brand.opacity(0.5), lineWidth: 1)
        )
    }

    private func negativeRow(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "minus.circle")
                .font(.system(size: 14))
                .foregroundStyle(AppColors.textSecondary.opacity(0.6))
                .padding(.top, 2)
            
            Text(text)
                .font(AppFonts.label(size: 12))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private func positiveRow(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "checkmark.circle")
                .font(.system(size: 14))
                .foregroundStyle(AppColors.brand)
                .padding(.top, 2)
            
            Text(text)
                .font(AppFonts.label(size: 13))
                .foregroundStyle(AppColors.textPrimary)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    ValuePropositionView()
        
}
