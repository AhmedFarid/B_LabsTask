//
//  HomeView.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            categoryView
            productView
        }
        .navigationTitle("Products")
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(HomeViewModel())
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
}
