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
                if let image = viewModel.image {
                    // Successfully loaded image
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()

                } else if viewModel.isLoading {
                    // Loading image
                    ZStack {
                        Color.primary.opacity(0.1)
                        ProgressView()
                    }

                } else {
                    // Placeholder image
                    Image("ChefHatPlaceholder", bundle: .main)
                        .resizable()
                        .scaledToFit()
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
        .onDisappear {
            viewModel.cancelLoadingImage()
        }
    }
}

#Preview {
    RecipeListView(
        viewModel: RecipeListViewModel(
            apiService: MockApiService(),
            imageRepository: ImageRepository(
                imageApi: ImageApi(),
                imageStore: ImageStore(
                    imageCache: ImageCache(),
                    imagePersistence: ImagePersistence()
                )
            )
        )
    )
}
