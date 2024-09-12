//
//  DetailViewModel.swift
//  SwiftUICryptoApp
//
//  Created by Viktor Drykin on 11.09.2024.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {

    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
    }

    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { coinDetail in

            }
            .store(in: &cancellables)
    }

}
