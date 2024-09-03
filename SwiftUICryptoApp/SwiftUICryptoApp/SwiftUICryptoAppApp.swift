//
//  SwiftUICryptoAppApp.swift
//  SwiftUICryptoApp
//
//  Created by Viktor Drykin on 19.08.2024.
//

import SwiftUI

@main
struct SwiftUICryptoAppApp: App {

    @StateObject private var vm = HomeViewModel()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
