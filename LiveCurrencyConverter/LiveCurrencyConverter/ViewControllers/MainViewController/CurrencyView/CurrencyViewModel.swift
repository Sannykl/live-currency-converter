//
//  CurrencyViewModel.swift
//  LiveCurrencyConverter
//
//  Created by Sasha Klovak on 07.12.2024.
//

import UIKit

protocol CurrencyViewModelProtocol {
    var titleString: String { get }
    var textColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var borderColor: UIColor { get }
    var arrowIcon: UIImage { get }
    var isTextFieldEnabled: Bool { get }
    var currencyType: CurrencyType { get }
    
    var currencyImage: UIImage { get }
    var currencyString: String { get }
    var currencyName: String { get }
    var currencyAmount: String { get }
    
    init(_ currency: Currency)
    func didChangeCurrency(_ currency: Currency)
    func didUpdateConvertation(_ convertation: ConvertationModel)
}


class FromCurrenceViewModel: CurrencyViewModelProtocol {
    let titleString = "YOU PAY"
    let textColor = UIColor(red: 3/255.0, green: 5/255.0, blue: 61/255.0, alpha: 1.0)
    let backgroundColor = UIColor.yellow.withAlphaComponent(0.7)
    let borderColor = UIColor.yellow.withAlphaComponent(0.8)
    let arrowIcon = UIImage(resource: .arrowDropDownFill)
    let isTextFieldEnabled = true
    let currencyType = CurrencyType.from

    private(set) var currencyImage: UIImage
    private(set) var currencyString: String
    private(set) var currencyName: String
    private(set) var currencyAmount: String = ""
    
    required init(_ currency: Currency) {
        currencyImage = currency.flag
        currencyString = currency.rawValue
        currencyName = currency.name
    }
    
    func didChangeCurrency(_ currency: Currency) {
        currencyImage = currency.flag
        currencyString = currency.rawValue
        currencyName = currency.name
    }
    
    func didUpdateConvertation(_ convertation: ConvertationModel) {}
}



class ToCurrencyViewModel: CurrencyViewModelProtocol {
    let titleString = "YOU GET"
    let textColor = UIColor.white
    let backgroundColor = UIColor.white.withAlphaComponent(0.1)
    let borderColor = UIColor.white.withAlphaComponent(0.2)
    let arrowIcon = UIImage(resource: .arrowDropDownFillWhite)
    let isTextFieldEnabled = false
    let currencyType = CurrencyType.to

    private(set) var currencyImage: UIImage
    private(set) var currencyString: String
    private(set) var currencyName: String
    private(set) var currencyAmount: String = ""
    
    required init(_ currency: Currency) {
        currencyImage = currency.flag
        currencyString = currency.rawValue
        currencyName = currency.name
    }
    
    func didChangeCurrency(_ currency: Currency) {
        currencyImage = currency.flag
        currencyString = currency.rawValue
        currencyName = currency.name
    }
    
    func didUpdateConvertation(_ convertation: ConvertationModel) {
        currencyAmount = "\(convertation.toCurrencyAmount)"
    }
}
