//
//  ExchangeRateViewController.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 27/04/2021.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    @IBOutlet weak var exchangeTextField: UITextField!
    @IBOutlet weak var exchangedAmountLabel: UILabel!
    @IBOutlet weak var exchangeButton: UIButton!
    @IBOutlet weak var fromCurrencyLabel: UILabel!
    @IBOutlet weak var toCurrencyLabel: UILabel!
    @IBOutlet weak var rateChange: UILabel!
    var rate : Double = 0
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func tappedExchangeButton(_ sender: Any) {
        toggleActivityIndicatore(show: true)
        guard let fromCurrency = fromCurrencyLabel.text else {
            presentAlert(message: "Nous avons rencontrer un probleme lors de la selection de la devise de depart")
            return
        }
        guard let toCurrency = toCurrencyLabel.text else {
            presentAlert(message: "Nous avons rencontrer un probleme lors de la selection de la devise final")
            return
        }
        print("Les currency...>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        print(fromCurrency)
        print(toCurrency)
        ExchangeService.shared.getExchangeAmount(toCurrency: toCurrency) { success, amountRate in
            self.toggleActivityIndicatore(show: false)
            if success{
                print("On essaye de l'afficher")
                print(amountRate.rates[toCurrency]!)
                self.rate = amountRate.rates[toCurrency]!
                self.uptdateView()
            }
        }
        
        
    }
    @IBAction func dissmissKeyboard(_ sender: Any) {
        exchangeTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    private func uptdateView() {
        rateChange.text = "\(Double(round(100 * rate) / 100))"
        guard let amountToCovert = Double(exchangeTextField.text!) else {
            print("Pas de montant a convertir ")
            return
        }
        let amountConvert = amountToCovert * rate
        print(amountConvert)
        exchangedAmountLabel.text = "\(Double(round(100 * amountConvert) / 100))"
        print(Double(round(100 * amountConvert) / 100))
    }
    private func toggleActivityIndicatore(show: Bool) {
        exchangeButton.isHidden = show
        activityIndicator.isHidden = !show
        activityIndicator.startAnimating()
    }
    @IBAction func tappedChangeCurrency(_ sender: Any) {
        if let fromCurrency = fromCurrencyLabel.text {
            let save = fromCurrency
            fromCurrencyLabel.text = toCurrencyLabel.text
            toCurrencyLabel.text = save
        }
        
    }
    func presentAlert(message : String)  {
        let alertVc = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVc, animated: true, completion: nil)
        
    }
}
