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
