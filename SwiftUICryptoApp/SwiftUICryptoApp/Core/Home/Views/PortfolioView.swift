//
//  PortfolioView.swift
//  SwiftUICryptoApp
//
//  Created by Viktor Drykin on 03.09.2024.
//

import SwiftUI

struct PortfolioView: View {

    @EnvironmentObject private var vm: HomeViewModel

    @State private var selectedCoin: CoinModel?
    @State private var quantityText: String = ""
    @State private var showCheckmark = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    if let selectedCoin = selectedCoin {
                        portfolioInputSection(for: selectedCoin)
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XmarkButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    trainlingSaveButton
                }
            }
            .onChange(of: vm.searchText) {
                if vm.searchText.isEmpty {
                    removeSelectedCoin()
                }
            }
        }
    }
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1.0)
                        )
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin)
                            }
                        }
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }

    private func updateSelectedCoin(_ coin: CoinModel) {
        selectedCoin = coin
        if
            let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
            let amount = portfolioCoin.currentHoldings
        {
            quantityText = String(amount)
        } else {
            quantityText = ""
        }

    }

    private func portfolioInputSection(for selectedCoin: CoinModel) -> some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin.symbol.uppercased()):")
                Spacer()
                Text(selectedCoin.currentPrice.asCurrencyWith6Decimals())
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }

    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }

    private var trainlingSaveButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("Save".uppercased())
            })
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
            )
        }
        .font(.headline)
    }

    private func saveButtonPressed() {
        guard 
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else {
            return
        }

        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)

        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }

        // hide keyboard
        UIApplication.shared.endEditing()

        // hide checkmark

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }

    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}


#Preview {
    PortfolioView()
        .environmentObject(DeveloperPreview.instance.homeVM)
}
