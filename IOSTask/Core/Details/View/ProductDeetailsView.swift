//
//  ProductDetailsView.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import SwiftUI

struct ProductLoadingView: View {

    @Binding var productId: Int?

    var body: some View {
        ZStack {
            if let productId = productId {
                ProductDetailsView(productId: productId)
            }
        }
    }
}

struct ProductDetailsView: View {

    @StateObject private var vm: ProductDetailsViewModel

    init(productId: Int) {
        _vm = StateObject(wrappedValue: ProductDetailsViewModel(productId: productId))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                productTitle
                productsImages
                priceViewCard
                descriptionText
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.3))
        .navigationTitle(vm.product?.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ProductDetailsView(productId: 1)
    }
}

extension ProductDetailsView {
    var productTitle: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(vm.product?.brand ?? "")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.gray)

            Text(vm.product?.title ?? "")
                .font(.title2)
                .fontWeight(.bold)

            Text("SKU: \(vm.product?.sku ?? "")")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

extension ProductDetailsView {
    var productsImages: some View {
        TabView{
            ForEach(vm.product?.images ?? [], id: \.self) { imageUrl in
                if let url = URL(string: imageUrl) {
                    ProductImageView(url: url)
                        .frame(height: 200)
                }
            }
        }
        .tabViewStyle(.page)
        .frame(height: 300)
    }
}

extension ProductDetailsView {
    var priceViewCard: some View {
        VStack(alignment: .leading) {
            priceStack
            Divider()
            stockWarrantyStack
            PaymentReturnPolicy
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
        )
        .padding()
    }
}
extension ProductDetailsView {
    var priceStack: some View {
        VStack(alignment: .leading) {
            Text("EGP \(vm.product?.price?.asNumberString() ?? "")")
                .font(.title)
                .foregroundStyle(.black)
                .bold()

            HStack {
                Text("Sale")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.red)

                Text("EGP \(((vm.product?.price ?? 0.0) * (vm.product?.discountPercentage ?? 0.0) + (vm.product?.price ?? 0.0)).asNumberString())")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.gray)
            }
        }.padding()
    }
}

extension ProductDetailsView {
    var stockWarrantyStack: some View {
        HStack {
            Text("In stock")
                .padding(5)
                .background(.gray)
                .cornerRadius(5)
            Spacer()
            Text("Warranty: 1 year")
                .foregroundStyle(.black)
        }
        .padding()
    }
}

extension ProductDetailsView {
    var PaymentReturnPolicy: some View {
        HStack {
            VStack(alignment: .leading) {
                Image(systemName: "creditcard")
                    .font(.title)
                    .foregroundStyle(.black)
                Text("Cash or Card")
                    .font(.footnote)
                    .foregroundStyle(.black)
                Text("Payment")
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(.black)
            }

            Spacer()

            VStack(alignment: .leading) {
                Image(systemName: "arrow.triangle.2.circlepath.circle")
                    .font(.title)
                    .foregroundStyle(.black)
                Text("30 days")
                    .font(.footnote)
                    .foregroundStyle(.black)
                Text("Return Policy")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.black)
            }
        }
        .padding()

    }
}

extension ProductDetailsView {
    var descriptionText: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Description")
                .font(.title3)
                .fontWeight(.bold)

            Text(vm.product?.description ?? "")
                .padding()
                .font(.subheadline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)

                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                )

        }
        .padding(.horizontal)

    }
}

