//
//  ProductImageView.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import SwiftUI

struct ProductImageView: View {
    @StateObject var vm: ProductImageViewModel

    init(url: URL) {
        _vm = StateObject(wrappedValue: ProductImageViewModel(url: url))
    }

    var body: some View {
        ZStack {
            if let image = vm.image {
                 Image(uiImage: image)
                    .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(height: 200)
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(.secondary)

            }
        }
    }
}

struct ProductImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductImageView(url: URL(string: "https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/thumbnail.png")!)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
