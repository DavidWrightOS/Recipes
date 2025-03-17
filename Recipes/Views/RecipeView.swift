//
//  RecipeView.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import SwiftUI

struct RecipeView: View {

    @ObservedObject private var viewModel: RecipeViewModel

    init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(spacing: 12) {
            Group {
                if viewModel.hasImageUrl {
                    if let result = viewModel.imageResult {
                        if let image = try? result.get() {
                            // Successfully loaded image
                            Image(uiImage: image)
                                .resizable()
                        } else {
                            // Error loading image
                            Self.defaultImage()
                        }
                    } else {
                        // Currently loading image
                        ZStack {
                            Color.primary.opacity(0.08)
                            ProgressView()
                        }
                    }
                } else {
                    // No image URL
                    Self.defaultImage()
                }
            }
            .frame(width: 60, height: 60)
            .clipShape(.rect(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.primaryText)

                Text(viewModel.secondaryText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .task {
            await viewModel.loadImage()
        }
    }
}

extension RecipeView {

    static func defaultImage() -> Image {
        Image(systemName: "photo")
            .resizable()
    }
}

#Preview {
    RecipeListView(
        viewModel: RecipeListViewModel(
            apiService: MockApiService(),
            imageRepository: ImageRepository.shared
        )
    )
}
