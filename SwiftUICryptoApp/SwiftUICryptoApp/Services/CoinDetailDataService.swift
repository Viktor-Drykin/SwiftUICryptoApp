//
//  CoinDetailDataService.swift
//  SwiftUICryptoApp
//
//  Created by Viktor Drykin on 12.09.2024.
//

import Foundation
import Combine

class CoinDetailDataService {

    @Published var coinDetails: CoinDetailModel? = nil
    var subscription: AnyCancellable?
    let coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }

    func getCoinDetails() {
        let urlString = "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community-data=false&developer_data=false&sparkline=false"
        guard let url = URL(string: urlString) else { return }

        subscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] coinDetails in
                self?.coinDetails = coinDetails
                self?.subscription?.cancel()
            })
    }

}



