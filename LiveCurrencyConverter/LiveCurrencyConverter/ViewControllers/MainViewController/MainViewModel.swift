//
//  MainViewModel.swift
//  LiveCurrencyConverter
//
//  Created by Sasha Klovak on 07.12.2024.
//

import UIKit
import Combine

final class MainViewModel {
    
    private let networkService: NetworkServiceProtocol
    
    @MainActor @Published private(set) var fromCurrencyCodeString = ""
    @MainActor @Published private(set) var fromCurrencyNameString = ""
    @MainActor @Published private(set) var fromCurrencyIcon: UIImage? = nil
    @MainActor @Published private(set) var fromCurrencyValueString = ""
    @MainActor @Published private(set) var toCurrencyCodeString = ""
    @MainActor @Published private(set) var toCurrencyNameString = ""
    @MainActor @Published private(set) var toCurrencyIcon: UIImage? = nil
    @MainActor @Published private(set) var toCurrencyAmountString = ""
    
    @MainActor @Published private(set) var errorString = ""
    
    private var fromCurrency = Currency.usd
    private var fromAmount: Double = 0.0
    private var toCurrency = Currency.eur
    
    private(set) var fromCurrencyViewModel: CurrencyViewModelProtocol!
    private(set) var toCurrencyViewModel: CurrencyViewModelProtocol!
    
    init(_ networkService: NetworkServiceProtocol = NetworkServiceMock()) {
        self.networkService = networkService
        prepareCurrencyViewModels()
    }
    
    func updateConverterInfo() {
        Task {
            let result = await networkService.convert(fromCurrency, amount: fromAmount, into: toCurrency)
            switch result {
            case .success(let data):
                do {
                    let convertationModel = try JSONDecoder().decode(ConvertationModel.self, from: data)
                    await didReceiveData(convertationModel)
                } catch {
                    await MainActor.run {
                        errorString = "We can't make this convertation right now. please try again later."
                    }
                }
            case .failure(let failure):
                await MainActor.run {
                    switch failure {
                    case .badUrl:
                        errorString = "Something went wrong"
                    case .serverError:
                        errorString = "We can't make this convertation right now. please try again later."
                    }
                }
            }
        }
    }
    
    private func didReceiveData(_ model: ConvertationModel) async {
        await MainActor.run {
            fromCurrencyViewModel.didUpdateConvertation(model)
            toCurrencyViewModel.didUpdateConvertation(model)
        }
    }
}

//MARK: view model generation methods
extension MainViewModel {
    
    private func prepareCurrencyViewModels() {
        fromCurrencyViewModel = FromCurrenceViewModel(fromCurrency)
        toCurrencyViewModel = ToCurrencyViewModel(toCurrency)
    }
    
    func currencyListViewModel(_ listType: CurrencyType) -> CurrencyListViewModel {
        let viewModel = CurrencyListViewModel(listType)
        viewModel.delegate = self
        return viewModel
    }
}

extension MainViewModel: CurrencyListViewModelDelegate {
    
}
