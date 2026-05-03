
//
//  AddMemoryView.swift
//  Closr
//
//  Created by Aditya Varshney on 03/05/26.
//

import SwiftUI
import PhotosUI

struct AddMemoryView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var selectedDate: Date = Date()
    @State private var location: String = ""
    @State private var category: String = ""
    @State private var specialNote: String = ""
    
    // Photos
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    
    let categoriesRow1 = ["Vacation", "Quality time", "Family"]
    let categoriesRow2 = ["Milestone", "Date", "Other"]
    
    // Character limits
    let titleLimit = 50
    let noteLimit = 500
    
    // We set a custom init to style the TextEditor background clear so we can use our own background
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.backgroundPrimary.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: AppSpacing.lg) {
                        
                        Text("Add a memory")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(AppColors.textPrimary)
                            .padding(.bottom, AppSpacing.sm)
                        
                        // Title
                        formSection(title: "Memory title") {
                            formTextField("e.g. \"Our first trip\"", text: $title, icon: "pencil")
                                .onChange(of: title) { newValue in
                                    if newValue.count > titleLimit {
                                        title = String(newValue.prefix(titleLimit))
                                    }
                                }
                            Text("\(title.count) / \(titleLimit) characters")
                                .font(.system(size: 12))
                                .foregroundStyle(AppColors.textSecondary)
                                .padding(.top, 4)
                        }
                        
                        // Photos
                        formSection(title: "Photos", subtitle: "Add one or more photos to bring it to life.\n(Optional)") {
                            
                            if !selectedImages.isEmpty {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: AppSpacing.sm) {
                                        ForEach(0..<selectedImages.count, id: \.self) { index in
                                            Image(uiImage: selectedImages[index])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 100, height: 100)
                                                .clipShape(RoundedRectangle(cornerRadius: AppRadius.md))
                                                .overlay(
                                                    Button {
                                                        selectedImages.remove(at: index)
                                                        selectedItems.remove(at: index)
                                                    } label: {
                                                        Image(systemName: "xmark.circle.fill")
                                                            .foregroundStyle(.white, .black.opacity(0.6))
                                                    }
                                                    .padding(6),
                                                    alignment: .topTrailing
                                                )
                                        }
                                        
                                        PhotosPicker(selection: $selectedItems, matching: .images) {
                                            RoundedRectangle(cornerRadius: AppRadius.md)
                                                .fill(AppColors.brandGlow)
                                                .frame(width: 100, height: 100)
                                                .overlay(
                                                    Image(systemName: "plus")
                                                        .foregroundStyle(AppColors.brand)
                                                )
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: AppRadius.md)
                                                        .stroke(AppColors.brand.opacity(0.3), lineWidth: 1)
                                                )
                                        }
                                    }
                                }
                            } else {
                                PhotosPicker(selection: $selectedItems, matching: .images) {
                                    HStack {
                                        Image(systemName: "photo")
                                        Text("Add photos")
                                    }
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(AppColors.brand)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .background(
                                        RoundedRectangle(cornerRadius: AppRadius.md)
                                            .fill(AppColors.brandGlow)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: AppRadius.md)
                                            .stroke(AppColors.brand.opacity(0.3), lineWidth: 1)
                                    )
                                }
                                .pressAnimation()
                            }
                        }
                        .onChange(of: selectedItems) { newItems in
                            Task {
                                selectedImages.removeAll()
                                for item in newItems {
                                    if let data = try? await item.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        selectedImages.append(uiImage)
                                    }
                                }
                            }
                        }
                        
                        // Date
                        formSection(title: "When was this?") {
                            HStack {
                                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                                    .labelsHidden()
                                    .colorScheme(.light)
                                    .tint(AppColors.brand)
                                Spacer()
                                Image(systemName: "pencil")
                                    .foregroundStyle(AppColors.textSecondary)
                            }
                            .padding(.horizontal, AppSpacing.md)
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: AppRadius.md)
                                    .fill(AppColors.backgroundCard)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: AppRadius.md)
                                    .stroke(AppColors.border, lineWidth: 1)
                            )
                        }
                        
                        // Location
                        formSection(title: "Where was this?", subtitle: "(Optional)") {
                            formTextField("Select a location", text: $location, icon: "mappin.and.ellipse")
                        }
                        
                        // Category
                        formSection(title: "Category", subtitle: "(Optional)") {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack(spacing: 8) {
                                    ForEach(categoriesRow1, id: \.self) { cat in
                                        categoryPill(cat)
                                    }
                                }
                                HStack(spacing: 8) {
                                    ForEach(categoriesRow2, id: \.self) { cat in
                                        categoryPill(cat)
                                    }
                                }
                            }
                        }
                        
                        // Special Note
                        formSection(title: "What makes this memory special?", subtitle: "(Optional)") {
                            TextEditor(text: $specialNote)
                                .font(.system(size: 16))
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(height: 120)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: AppRadius.md)
                                        .fill(AppColors.backgroundCard)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppRadius.md)
                                        .stroke(AppColors.border, lineWidth: 1)
                                )
                                .onChange(of: specialNote) { newValue in
                                    if newValue.count > noteLimit {
                                        specialNote = String(newValue.prefix(noteLimit))
                                    }
                                }
                            
                            Text("\(specialNote.count) / \(noteLimit) characters")
                                .font(.system(size: 12))
                                .foregroundStyle(AppColors.textSecondary)
                                .padding(.top, 4)
                        }
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.top, AppSpacing.md)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(AppColors.textPrimary)
                    .font(.system(size: 16, weight: .medium))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // TODO: Implement actual save logic to backend
                        print("Saving memory: \(title), \(selectedDate), \(category)")
                        dismiss()
                    }
                    .foregroundStyle(title.isEmpty ? AppColors.textSecondary : AppColors.brand)
                    .font(.system(size: 16, weight: .bold))
                    .disabled(title.isEmpty)
                }
            }
            .toolbarBackground(AppColors.backgroundPrimary, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .preferredColorScheme(.light)
    }
    
    private func categoryPill(_ cat: String) -> some View {
        Button {
            category = cat
        } label: {
            Text(cat)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(category == cat ? AppColors.buttonPrimaryText : AppColors.textPrimary)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(category == cat ? AppColors.brand : AppColors.backgroundCard)
                )
                .overlay(
                    Capsule()
                        .stroke(category == cat ? Color.clear : AppColors.border, lineWidth: 1)
                )
        }
        .pressAnimation()
    }
    
    private func formSection<Content: View>(title: String, subtitle: String? = nil, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(AppColors.textSecondary)
                    .padding(.bottom, 2)
            }
            
            content()
        }
    }
    
    private func formTextField(_ placeholder: String, text: Binding<String>, icon: String) -> some View {
        HStack {
            if icon == "mappin.and.ellipse" {
                Image(systemName: icon)
                    .foregroundStyle(AppColors.textSecondary)
            }
            
            TextField(placeholder, text: text)
                .font(.system(size: 16))
                .foregroundStyle(AppColors.textPrimary)
            
            Spacer()
            
            if icon == "pencil" {
                Image(systemName: icon)
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
                .stroke(AppColors.border, lineWidth: 1)
        )
    }
}

#Preview {
    AddMemoryView()
}
