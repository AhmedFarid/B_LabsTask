//
//  ProductViewCard.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import SwiftUI

struct ProductViewCard: View {
    let product: Product

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            TabView{
                ForEach(product.images ?? [], id: \.self) { imageUrl in
                    ProductImageView(url: imageUrl)
                        .frame(width: 150)
                }

            }
            .frame(width: 150)
            .frame(maxHeight: 150)
            .tabViewStyle(.page)
            productDetails
            Spacer()

        }
        .background(
            Color.white.opacity(0.01)
        )
    }
}

struct ProductViewCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductViewCard(product: Product(id: 1, title: "Annibale Colombo Bed", description: "The Annibale Colombo Bed is a luxurious and elegant bed frame, crafted with high-quality materials for a comfortable and stylish bedroom.", sku: "36T6X4M3", category: "furniture", price: 1899.99, discountPercentage: 0.29, rating: 4.14, stock: 47, brand: "Annibale Colombo", thumbnail: "https://cdn.dummyjson.com/products/images/furniture/Annibale%20Colombo%20Bed/thumbnail.png", images: ["https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/1.png",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 "https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/2.png",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 "https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/3.png"], availabilityStatus: "In Stock"))
        .previewLayout(.sizeThatFits)
    }
}


extension ProductViewCard {
    var productDetails: some View {
        VStack(alignment: .leading, spacing: 12) {
            CategoryButton(text: product.category ?? "", isSelected: true)
                .frame(height: 16)
            productPrice

            Text(product.title ?? "")
                .font(.headline)
                .bold()
                .lineLimit(2)

            RateView(rating: .constant(Int(product.rating ?? 0.0)))
        }
    }
}

extension ProductViewCard {
    var productPrice: some View {
        VStack(alignment: .leading) {
            Text("EGP \(product.price?.asNumberString() ?? "")")
                .font(.subheadline)
                .bold()

            HStack {
                Text("Sale")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.red)

                Text("EGP \(((product.price ?? 0.0) * (product.discountPercentage ?? 0.0) + (product.price ?? 0.0)).asNumberString())")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.gray)
            }
        }
    }
}

