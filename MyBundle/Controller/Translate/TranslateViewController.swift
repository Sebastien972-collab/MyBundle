//
//  TranslateViewController.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 27/04/2021.
//

import UIKit

class TranslateViewController: UIViewController {
    
    @IBOutlet weak private var fromLanguageLabel: UILabel!
    @IBOutlet weak private var fromTextView: UITextView!
    @IBOutlet weak private var translateLabel: UILabel!
    @IBOutlet weak private var languagesPickerView: UIPickerView!
    @IBOutlet weak private var translateButton: UIButton!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    private var toLangage = LanguageAvailable.language[0]
    private var languages = LanguageAvailable.language
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toLangage = LanguageAvailable.language[14]
        activityIndicator.isHidden = true
        
    }
    @IBAction func dissmissKeyboard(_ sender: Any) {
        fromTextView.resignFirstResponder()
    }
    
    
    @IBAction func tappedTranslateButton(_ sender: Any) {
        KitUtils.toggleActivityIndicator(button: translateButton, show: true, activityIndicator: activityIndicator)
        guard let fromText = fromTextView.text else {
            KitUtils.toggleActivityIndicator(button: translateButton, show: false, activityIndicator: activityIndicator)
            return present(KitUtils.presentAlert(message: "Vous devez entrer un text à traduire"), animated: true) {
                KitUtils.toggleActivityIndicator(button: self.translateButton, show: false, activityIndicator: self.activityIndicator)
            }
        }
        TranslationService.shared.getTranslatedText(text: fromText, toLangage: toLangage) { success, translatedText, error in
            guard success, let translatedText = translatedText, error == nil else {
                return self.present(KitUtils.presentAlert(message: error?.localizedDescription ?? "Sorry unknow error"), animated: true) {
                    KitUtils.toggleActivityIndicator(button: self.translateButton, show: false, activityIndicator: self.activityIndicator)
                }
            }
            KitUtils.toggleActivityIndicator(button: self.translateButton, show: false, activityIndicator: self.activityIndicator)
            self.translateLabel.text = translatedText.translatedText
            self.fromLanguageLabel.text = LanguageAvailable.detectLanguage(bcpcode47: translatedText.detectedSourceLanguage).langage
            print("La réponse est ")
            print(translatedText.translatedText)
        }
    }
}
extension TranslateViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        languages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        languages[row].langage
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        toLangage = languages[row]
    }
    
}
