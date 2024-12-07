//
//  ConvertaionModel.swift
//  LiveCurrencyConverter
//
//  Created by Sasha Klovak on 07.12.2024.
//

import Foundation

struct ConvertationModel: Decodable {
    let fromCurrency: String
    let fromCurrencyAmount: Double
    let toCurrency: String
    let toCurrencyAmount: Double
}
