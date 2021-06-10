//
//  ExchangeRateViewController.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 27/04/2021.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    @IBOutlet weak private var exchangeTextField: UITextField!
    @IBOutlet weak private var exchangedAmountLabel: UILabel!
    @IBOutlet weak private var exchangeButton: UIButton!
    @IBOutlet weak private var fromCurrencyLabel: UILabel!
    @IBOutlet weak private var rateChange: UILabel!
    private var rate : Double = 0
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var currencyPickerView: UIPickerView!
    @IBOutlet weak private var changeCurrencyButton: UIButton!
    private var currencys = Currency.currencys
    private var rowCurrency = 0
    private var fromEur = true {
        didSet{
            guard let fromCurrency = fromCurrencyLabel.text else {
                return
            }
            if !fromEur {
                let saveElement = currencys[rowCurrency]
                currencys.removeAll()
                currencys.append(fromCurrency)
                fromCurrencyLabel.text = saveElement
                
            } else {
                fromCurrencyLabel.text = "EUR"
                currencys = Currency.currencys
            }
            currencyPickerView.reloadAllComponents()
    
        }
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    
    @IBAction private func tappedExchangeButton(_ sender: Any) {
        Utils.toggleActivityIndicator(button: exchangeButton, show: true, activityIndicator: activityIndicator)
        let indexToCurrency = currencyPickerView.selectedRow(inComponent: 0)
        var toCurrency = currencys[indexToCurrency]
        if !fromEur {
            guard let fromCurrency = fromCurrencyLabel.text else {
                return present(Utils.presentAlert(message: "Can't find from currency"), animated: true, completion: nil)
            }
            toCurrency = fromCurrency
        }
        ExchangeService.shared.getExchangeAmount(toCurrency: toCurrency) { success, amountRate, error  in
            Utils.toggleActivityIndicator(button: self.exchangeButton, show: false, activityIndicator: self.activityIndicator)
            guard success, error == nil, let amountRate = amountRate else {
                return self.present(Utils.presentAlert(message: error?.localizedDescription ?? "Unknown error"), animated: true, completion: nil)
            }
            guard success else {
                return self.present(Utils.presentAlert(message: "Exchange rate not found "), animated: true, completion: nil)
            }
            print(amountRate.rates[toCurrency]!)
            self.rate = amountRate.rates[toCurrency]!
            self.uptdateView()
        }
    }
    @IBAction private func dissmissKeyboard(_ sender: Any) {
        exchangeTextField.resignFirstResponder()
    }
    @IBAction private func tappedExchangeRateButton(_ sender: Any) {
        fromEur.toggle()
    }
    
    private func uptdateView() {
        if !fromEur {
            rate = 1 / rate
        }
        rateChange.text = "\(Double(round(100 * rate) / 100))"
        guard let amountToCovert = Double(exchangeTextField.text!) else {
            return 
        }
        let amountConvert = amountToCovert * rate
        print(amountConvert)
        exchangedAmountLabel.text = "\(Double(round(100 * amountConvert) / 100))"
        print(Double(round(100 * amountConvert) / 100))
    }
}
extension ExchangeRateViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencys.count
    }
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencys[row]
    }
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowCurrency = row
    }
}
