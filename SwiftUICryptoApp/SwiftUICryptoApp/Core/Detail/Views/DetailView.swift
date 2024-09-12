//
//  DetailView.swift
//  SwiftUICryptoApp
//
//  Created by Viktor Drykin on 11.09.2024.
//

import SwiftUI

struct DetailLoadingView: View {

    @Binding var coin: CoinModel?

    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {

    @StateObject var vm: DetailViewModel
    let coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail view for \(coin.name)")
    }

    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
