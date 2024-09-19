//
//  HomeView.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var vm: HomeViewModel
    @State private var showDetailsView: Bool = false
    @State private var productId: Int? = nil

    var body: some View {
        VStack(spacing: 0) {
            categoryView
            productView
        }
        .navigationDestination(isPresented: $showDetailsView) {
            ProductLoadingView(productId: $productId)
        }
        .navigationTitle("Products")
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(HomeViewModel(dataService: ProductListDataService()))
    }

}

extension HomeView {
    var categoryView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(vm.category, id: \.name) { category in
                    CategoryButton(text: category.name ?? "", isSelected: vm.selectedCategory == category ? true : false)
                        .onTapGesture {
                            vm.selectedCategory = category
                            vm.getProduct(byCategory: category.slug ?? "")
                        }
                }
            }
            .padding()
        }
    }
}

extension HomeView {
    var productView: some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.productsList) { product in
                    ProductViewCard(product: product)
                        .padding()
                        .onTapGesture {
                            segue(productId: product.id ?? 0)
                        }
                        .onAppear {
                            if product == vm.productsList.last {
                                vm.getMoreData()
                            }
                        }
                }

                if vm.isLoading {
                    ProgressView("Loading...")
                        .padding()
                }
            }


        }
    }

    private func segue(productId: Int) {
        self.productId = productId
        showDetailsView.toggle()
    }
}
