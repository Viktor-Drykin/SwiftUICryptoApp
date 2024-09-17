//
//  SettingsView.swift
//  SwiftUICryptoApp
//
//  Created by Viktor Drykin on 16.09.2024.
//

import SwiftUI

struct SettingsView: View {

    let defaultURL = URL(string: "http://www.google.com")
    let youtubeURL = URL(string: "http://www.youtube.com")
    let coffeeURL = URL(string: "http://www.buymeacoffee.com")
    let coingeckoURL = URL(string: "http://www.coingecko.com")
    let personalURL = URL(string: "http://www.github.com")

    var body: some View {
        NavigationView {
            ZStack {

                Color.theme.background
                    .ignoresSafeArea()

                List {
                    swiftfulThinkingSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coingeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    developerSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }
            .font(.headline)
            .tint(Color.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XmarkButton()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    var swiftfulThinkingSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made for studying SwiftUI. It uses MVMM architecture, Combine and CoreData")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            if let youtubeURL = youtubeURL {
                Link("Subscribe on Youtube", destination: youtubeURL)
            }
            if let coffeeURL = coffeeURL {
                Link("Coffe link", destination: coffeeURL)
            }
        } header: {
            Text("Swiftful Thinking")
        }
    }

    var coingeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .frame(height: 100)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            if let coingeckoURL = coingeckoURL {
                Link("Visit CoinGecko", destination: coingeckoURL)
            }
        } header: {
            Text("CoinGecko")
        }
    }

    var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed for SwiftUI studying. It's written 100% with SwiftUI and Swift. The project benefits from multi-threading, publishers/subscribers and data persistance")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            if let personalURL = personalURL {
                Link("Visit github", destination: personalURL)
            }
        } header: {
            Text("Developer")
        }
    }

    var applicationSection: some View {
        Section {
            if let defaultURL = defaultURL {
                Link("Terms of Service", destination: defaultURL)
                Link("Privacy Policy", destination: defaultURL)
                Link("Company Website", destination: defaultURL)
                Link("Learn More", destination: defaultURL)
            }
        } header: {
            Text("Application")
        }
    }
}
