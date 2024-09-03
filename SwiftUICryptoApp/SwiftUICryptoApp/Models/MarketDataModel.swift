//
//  MarketDataModel.swift
//  SwiftUICryptoApp
//
//  Created by Viktor Drykin on 01.09.2024.
//

import Foundation

// URL: https://api.coingecko.com/api/v3/global

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
}

extension MarketDataModel {

    var marketCap: String {
        return totalMarketCap["usd"].map { "$" + $0.formattedWithAbbreviations() } ?? ""
    }

    var volume: String {
        return totalVolume["usd"].map { "$" + $0.formattedWithAbbreviations() } ?? ""
    }

    var btcDominance: String {
        return marketCapPercentage["btc"].map { "\($0.asPercentString())" } ?? ""
    }
}
