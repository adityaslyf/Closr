
//
//  MemoriesView.swift
//  Closr
//
//  Created by Aditya Varshney on 03/05/26.
//

import SwiftUI

struct MemoriesView: View {
    @State private var showAddMemory = false
    
    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.ignoresSafeArea()
            
            VStack {
                // Header
                HStack {
                    Text("Memories")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(AppColors.textPrimary)
                    
                    Spacer()
                    
                    Button {
                        // Profile Action
                    } label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .font(.system(size: 24))
                            .foregroundStyle(AppColors.textSecondary)
                    }
                    .pressAnimation()
                }
                .padding(.horizontal, AppSpacing.lg)
                .padding(.top, AppSpacing.md)
                
                Spacer()
                
                // Empty State
                VStack(spacing: AppSpacing.md) {
                    // Illustration Mock
                    ZStack {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 80))
                            .foregroundStyle(AppColors.brand.opacity(0.8))
                        
                        Image(systemName: "pin.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(AppColors.textPrimary)
                            .offset(x: -20, y: -40)
                    }
                    .padding(.bottom, AppSpacing.lg)
                    
                    Text("Start adding memories")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(AppColors.textPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text("Reminisce on your relationship past with your partner!")
                        .font(.system(size: 16))
                        .foregroundStyle(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppSpacing.xl)
                    
                    // Arrow placeholder
                    Image(systemName: "arrow.turn.right.down")
                        .font(.system(size: 40))
                        .foregroundStyle(AppColors.textSecondary.opacity(0.5))
                        .padding(.top, AppSpacing.xl)
                        .offset(x: 20)
                }
                .padding(.bottom, 60) // Space for arrow/FAB
                
                Spacer()
            }
            
            // FAB
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        showAddMemory = true
                    } label: {
                        ZStack {
                            Circle()
                                .fill(AppColors.brand)
                                .frame(width: 64, height: 64)
                                .shadow(color: AppColors.brand.opacity(0.3), radius: 10, y: 5)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(AppColors.buttonPrimaryText)
                        }
                    }
                    .pressAnimation()
                    .padding(.trailing, AppSpacing.lg)
                    .padding(.bottom, AppSpacing.xl)
                }
            }
        }
        .fullScreenCover(isPresented: $showAddMemory) {
            AddMemoryView()
        }
    }
}

#Preview {
    MemoriesView()
}
