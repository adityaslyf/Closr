
//
//  AvatarPickerView.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import PhotosUI

/// A circular avatar picker with a camera placeholder, "ADD" label,
/// and a "+" badge. Supports selecting a photo from the photo library.
struct AvatarPickerView: View {

    // MARK: - Bindings
    @Binding var selectedImage: UIImage?

    // MARK: - Private State
    @State private var photosItem: PhotosPickerItem? = nil
    @State private var isLoading: Bool               = false

    // MARK: - Layout
    private let size: CGFloat = 80

    // MARK: - Body
    var body: some View {
        PhotosPicker(selection: $photosItem,
                     matching: .images,
                     photoLibrary: .shared()) {
            ZStack(alignment: .bottomTrailing) {
                avatarCircle
                plusBadge
            }
        }
        .onChange(of: photosItem) { _, newItem in
            loadImage(from: newItem)
        }
    }

    // MARK: - Sub-views

    private var avatarCircle: some View {
        ZStack {
            // Background circle
            Circle()
                .fill(AppColors.backgroundSecondary)
                .frame(width: size, height: size)

            if let image = selectedImage {
                // Selected photo
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
                    .transition(.opacity)
            } else {
                // Camera placeholder
                VStack(spacing: 4) {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(AppColors.textSecondary.opacity(0.6))

                    Text("ADD")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(AppColors.brand)
                        .tracking(1.5)
                }
            }
        }
    }

    private var plusBadge: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 28, height: 28)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)

            Image(systemName: "plus")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(AppColors.backgroundPrimary)
        }
        .offset(x: 2, y: 2)
    }

    // MARK: - Image Loading

    private func loadImage(from item: PhotosPickerItem?) {
        guard let item else { return }
        isLoading = true
        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                await MainActor.run {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selectedImage = uiImage
                    }
                }
            }
            await MainActor.run { isLoading = false }
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        AppColors.backgroundPrimary.ignoresSafeArea()
        AvatarPickerView(selectedImage: .constant(nil))
    }
}
