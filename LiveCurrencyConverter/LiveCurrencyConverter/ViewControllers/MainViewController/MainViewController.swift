//
//  MainViewController.swift
//  LiveCurrencyConverter
//
//  Created by Sasha Klovak on 07.12.2024.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    private let viewModel = MainViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    private var titleLabel: UILabel!
    
    private var fromView: CurrencyView!
    private var fromImageView: UIImageView!
    private var fromCurrencyLabel: UILabel!
    private var fromCurrencyNameLabel: UILabel!
    
    private var toView: UIView!
    private var toImageView: UIImageView!
    private var toCurrencyLabel: UILabel!
    private var toCurrencyNameLabel: UILabel!
    private var toCurrencyAmountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        prepareUI()
        prepareObservers()
        viewModel.updateConverterInfo()
    }
    
    private func prepareUI() {
        view.backgroundColor = UIColor(red: 10/255.0, green: 15/255.0, blue: 46/255.0, alpha: 1.0)

        addTitle()
        addFromCurrencyView()
        addToCurrencyView()
        addReverseButton()
    }
    
    private func addTitle() {
        titleLabel = UILabel(frame: .zero)
        titleLabel.text = "Currency convertor"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
     }
    
    private func addFromCurrencyView() {
        fromView = CurrencyView(viewModel.fromCurrencyViewModel)
        fromView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fromView)
        
        let constraints = [
            fromView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            fromView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            fromView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            fromView.heightAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addToCurrencyView() {
        toView = CurrencyView(viewModel.toCurrencyViewModel)
        toView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toView)
        
        let constraints = [
            toView.topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: 10),
            toView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            toView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            toView.heightAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addReverseButton() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(resource: .arrowUpDownFill), for: .normal)
        button.backgroundColor = UIColor(red: 227/255.0, green: 232/255.0, blue: 229/255.0, alpha: 1.0)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1.0).cgColor
        
        button.addTarget(self, action: #selector(revertButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        let constraints = [
            button.topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: -15),
            button.centerXAnchor.constraint(equalTo: fromView.centerXAnchor, constant: 0),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func prepareKeyboardView() {
        
    }
    
    private func prepareObservers() {
        
    }
}

//MARK: button actions methods
private extension MainViewController {
    
    @objc func revertButtonAction() {
        print("Revert button tapped")
    }
}

extension MainViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}


extension MainViewController: CurrencyViewDelegate {
    
    func didTapCurrencyButton(for type: CurrencyType) {
        
    }
}
