//
//  RandomPhotoView.swift
//  Masik
//
//  Created by Роман Ломтев on 12.06.2025.
//

import SwiftUI

struct RandomPhotoView: View {
    @StateObject private var viewModel = RandomPhotoViewModel()

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(viewModel.images.indices, id: \ .self) { index in
                        Image(uiImage: viewModel.images[index])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                width: geometry.size.height,
                                height: geometry.size.height
                            )
                            .clipped()
                            .cornerRadius(12)
                            .shadow(radius: 2)
                    }
                }
                .padding(.horizontal)
            }
        }
        .frame(height: 160)
    }
}
