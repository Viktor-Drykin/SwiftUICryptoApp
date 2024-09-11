//
//  CoinDataService.swift
//  SwiftUICryptoApp
//
//  Created by Viktor Drykin on 26.08.2024.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?

    private let marketsURLString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"

    init() {
        getCoins()
    }

    func getCoins() {
        guard let url = URL(string: marketsURLString) else { return }

        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] coins in
                self?.allCoins = coins
                self?.coinSubscription?.cancel()
            })
    }

}
