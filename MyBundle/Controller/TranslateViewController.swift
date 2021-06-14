//
//  TranslateViewController.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 27/04/2021.
//

import UIKit
class TranslateViewController: UIViewController {
    @IBOutlet weak private var fromExpression: UITextField!
    @IBOutlet weak private var toExpression: UITextField!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var translateButton: UIButton!
    @IBOutlet weak private var fromLangagePickerView: UIPickerView!
    @IBOutlet weak private var toLangagePickerView: UIPickerView!
    @IBOutlet weak private var swapLangageButton: UIButton!
    private var langages = LanguageAvailable.language
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden.toggle()
        print(userDefault.integer(forKey: "FavoriteLanguageRow"))
    }
    override func viewWillAppear(_ animated: Bool) {                                       
    }
    @IBAction func tappedTranslateButtton(_ sender: Any) {
        Utils.toggleActivityIndicator(button: translateButton, show: true, activityIndicator: activityIndicator)
        guard let textToTranslate = fromExpression.text else { return  }
        print(textToTranslate)
        Utils.toggleActivityIndicator(button: translateButton, show: false, activityIndicator: activityIndicator)
    }
    @IBAction func resignKeyboard(_ sender: Any) {
        fromLangagePickerView.resignFirstResponder()
        toLangagePickerView.resignFirstResponder()
    }
    @IBAction func tappedExchangeLangageExpresson(_ sender: Any) {
    }
}
extension TranslateViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        langages[row].langage
    }
    
}
