//
//  IOSTaskApp.swift
//  IOSTask
//
//  Created by Farido on 10/09/2024.
//

import SwiftUI

@main
struct IOSTaskApp: App {
    @StateObject private var vm = HomeViewModel(dataService: ProductListDataService())

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .environmentObject(vm)

        }
    }
}
