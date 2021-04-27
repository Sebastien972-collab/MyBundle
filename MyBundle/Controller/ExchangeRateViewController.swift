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
    
    @IBAction func tappedExchangeButton(_ sender: Any) {
        ExchangeService.shared.getExchangeAmount(fromCurrency: "EUR", toCurrency: "USD") { success, amountRate in
            if success{
                self.rateChange.text =  "\(amountRate)"
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
