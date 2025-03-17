//
//  EmptyListView.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import SwiftUI

struct EmptyListView: View {

    private let viewModel: EmptyListViewModel

    init(viewModel: EmptyListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            if viewModel.showLoadingIndicator {
                VStack {
                    Spacer().frame(height: 100)
                    ProgressView()
                        .controlSize(.large)
                    Spacer()
                }
            }

            VStack(spacing: 10) {
                Text(viewModel.title)
                    .font(.system(.title2, weight: .bold))
                    .multilineTextAlignment(.center)


                Text(viewModel.description)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                if viewModel.showRetryButton {
                    Button {
                        viewModel.didTapRetry()
                    } label: {
                        Text(viewModel.retryButtonTitle)
                            .bold()
                            .padding(10)
                    }
                    .disabled(viewModel.retryButtonDisabled)
                }

                Image(systemName: "fork.knife")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .colorMultiply(.primary.opacity(0.15))
            }
            .frame(maxWidth: .infinity)
        }
        .padding(20)
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
