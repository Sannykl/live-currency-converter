//
//  CurrencyView.swift
//  LiveCurrencyConverter
//
//  Created by Sasha Klovak on 07.12.2024.
//

import UIKit

protocol CurrencyViewDelegate: AnyObject {
    func didTapCurrencyButton(for type: CurrencyType)
}

final class CurrencyView: UIView {
    
    private var titleLabel: UILabel!
    private var currencyImageView: UIImageView!
    private var currencyLabel: UILabel!
    private var arrowImageView: UIImageView!
    private var currencyNameLabel: UILabel!
    private var textField: UITextField!
    
    private let viewModel: CurrencyViewModelProtocol
    
    init(_ viewModel: CurrencyViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        prepareUI()
        fill(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareUI() {
        layer.cornerRadius = 20.0
        layer.borderWidth = 1.0
        
        prepareTitleLabel()
        prepareCurrencyImageView()
        prepareCurrencyLabel()
        prepareArrowImageView()
        prepareCurrencyNameLabel()
        prepareCurrencyButton()
        prepareTextField()
    }
    
    private func prepareTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        let titleConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(titleConstraints)
    }
    
    private func prepareCurrencyImageView() {
        currencyImageView = UIImageView(frame: .zero)
        currencyImageView.contentMode = .scaleAspectFill
        currencyImageView.layer.cornerRadius = 20.0
        currencyImageView.layer.masksToBounds = true
        currencyImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(currencyImageView)
        
        let imageViewConstraints = [
            currencyImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            currencyImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 35),
            currencyImageView.widthAnchor.constraint(equalToConstant: 40),
            currencyImageView.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
    private func prepareCurrencyLabel() {
        currencyLabel = UILabel()
        currencyLabel.font = .systemFont(ofSize: 24, weight: .bold)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(currencyLabel)
        
        let currencyConstraints = [
            currencyLabel.leftAnchor.constraint(equalTo: currencyImageView.rightAnchor, constant: 10),
            currencyLabel.centerYAnchor.constraint(equalTo: currencyImageView.centerYAnchor, constant: -5)
        ]
        NSLayoutConstraint.activate(currencyConstraints)
    }
    
    private func prepareArrowImageView() {
        arrowImageView = UIImageView(frame: .zero)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrowImageView)
        
        let arrowConstraints = [
            arrowImageView.leftAnchor.constraint(equalTo: currencyLabel.rightAnchor, constant: 0),
            arrowImageView.centerYAnchor.constraint(equalTo: currencyLabel.centerYAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(arrowConstraints)
    }
    
    private func prepareCurrencyNameLabel() {
        currencyNameLabel = UILabel()
        currencyNameLabel.font = .systemFont(ofSize: 10, weight: .regular)
        currencyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(currencyNameLabel)
        
        let currencyNameConstraints = [
            currencyNameLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 0),
            currencyNameLabel.leadingAnchor.constraint(equalTo: currencyLabel.leadingAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(currencyNameConstraints)
    }
    
    private func prepareCurrencyButton() {
        let currencyButton = UIButton(type: .custom)
        currencyButton.translatesAutoresizingMaskIntoConstraints = false
        currencyButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        currencyButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(currencyButton)
        
        let currencyButtonConstraints = [
            currencyButton.topAnchor.constraint(equalTo: currencyImageView.topAnchor, constant: 0),
            currencyButton.leadingAnchor.constraint(equalTo: currencyImageView.leadingAnchor, constant: -10),
            currencyButton.trailingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: 10),
            currencyButton.bottomAnchor.constraint(equalTo: currencyNameLabel.bottomAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(currencyButtonConstraints)
    }
    
    private func prepareTextField() {
        textField = UITextField()
        textField.font = .systemFont(ofSize: 42, weight: .bold)
        textField.delegate = self
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.tintColor = UIColor(red: 3/255.0, green: 5/255.0, blue: 61/255.0, alpha: 1.0)
        textField.keyboardType = .decimalPad
        textField.minimumFontSize = 16
        textField.adjustsFontSizeToFitWidth = true
        addSubview(textField)
        
        let textFieldConstraints = [
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -35),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            textField.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 70) / 2)
        ]
        NSLayoutConstraint.activate(textFieldConstraints)
    }
    
    private func fill(with viewModel: CurrencyViewModelProtocol) {
        backgroundColor = viewModel.backgroundColor
        layer.borderColor = viewModel.borderColor.cgColor
        
        titleLabel.text = viewModel.titleString
        titleLabel.textColor = viewModel.textColor.withAlphaComponent(0.6)
        
        currencyImageView.image = viewModel.currencyImage
        currencyLabel.text = viewModel.currencyString
        currencyLabel.textColor = viewModel.textColor
        
        arrowImageView.image = viewModel.arrowIcon
        
        currencyNameLabel.text = viewModel.currencyName
        currencyNameLabel.textColor = viewModel.textColor.withAlphaComponent(0.6)
        
        textField.textColor = viewModel.textColor
        textField.tintColor = viewModel.textColor
        textField.isEnabled = viewModel.isTextFieldEnabled
        if viewModel.isTextFieldEnabled {
            textField.becomeFirstResponder()
        }
    }
    
    @objc private func buttonAction() {
        
    }
}

extension CurrencyView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
