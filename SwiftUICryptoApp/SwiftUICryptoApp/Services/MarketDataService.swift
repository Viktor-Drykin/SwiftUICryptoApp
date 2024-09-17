//
//  MarketDataService.swift
//  SwiftUICryptoApp
//
//  Created by Viktor Drykin on 01.09.2024.
//

import Foundation
import Combine

class MarketDataService {

    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?

    private let marketsURLString = "https://api.coingecko.com/api/v3/global"

    init() {
        getData()
    }

    func getData() {
        guard let url = URL(string: marketsURLString) else { return }

        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] globalData in
                self?.marketData = globalData.data
                self?.marketDataSubscription?.cancel()
            })
    }

}
