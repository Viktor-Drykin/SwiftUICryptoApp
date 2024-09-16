//
//  DetailViewModel.swift
//  SwiftUICryptoApp
//
//  Created by Viktor Drykin on 11.09.2024.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {

    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var coin: CoinModel
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil

    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }

    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArrays in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)

        coinDetailService.$coinDetails
            .sink { [weak self] coinDetails in
                self?.coinDescription = coinDetails?.readableDescription
                self?.websiteURL = coinDetails?.links?.homepage?.first
                self?.redditURL = coinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }

    private func mapDataToStatistics(coinDetails: CoinDetailModel?, coin: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        let overviewArray = makeOverviewArray(coin: coin)
        let additionalArray = makeAdditionalArray(coinDetails: coinDetails, coin: coin)
        return (overview: overviewArray, additional: additionalArray)
    }

    private func makeOverviewArray(coin: CoinModel) -> [StatisticModel] {
        let priceStat = {
            let price = coin.currentPrice.asCurrencyWith6Decimals()
            let priceChange = coin.priceChangePercentage24H
            return StatisticModel(title: "Current Price", value: price, percentageChange: priceChange)
        }()
        let marketCapStat = {
            let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
            let marketCapChange = coin.marketCapChangePercentage24H
            return StatisticModel(title: "Market Capitalisation", value: marketCap, percentageChange: marketCapChange)
        }()
        let rankStat = {
            let rank = "\(coin.rank)"
            return StatisticModel(title: "Rank", value: rank)
        }()
        let volumeStat = {
            let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
            return StatisticModel(title: "Volume", value: volume)
        }()
        return [priceStat, marketCapStat, rankStat, volumeStat]
    }

    private func makeAdditionalArray(coinDetails: CoinDetailModel?, coin: CoinModel) -> [StatisticModel] {
        let highStat = {
            let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
            return StatisticModel(title: "24h High", value: high)
        }()
        let lowStat = {
            let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
            return StatisticModel(title: "24h Low", value: low)
        }()
        let priceChangeStat = {
            let priceChange = coin.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
            let pricePercentChange2 = coin.priceChangePercentage24H
            return StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange2)
        }()
        let marketCapChangeStat = {
            let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations () ?? "")
            let marketCapPercentChange2 = coin.marketCapChangePercentage24H
            return StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange:
                                    marketCapPercentChange2)
        }()
        let blockStat = {
            let blockTime = coinDetails?.blockTimeInMinutes ?? 0
            let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
            return StatisticModel(title: "Block time", value: blockTimeString)
        }()
        let hashingStat = {
            let hashing = coinDetails?.hashingAlgorithm ?? "n/a"
            return StatisticModel(title: "Hashing Algorithm", value: hashing)
        }()
        return [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat]
    }
}
