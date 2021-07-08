//
//  TranslateViewController.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 27/04/2021.
//

import UIKit
class TranslateViewController: UIViewController {
    @IBOutlet weak var fromLangageButton: UIButton!
    @IBOutlet weak var toLangageButton: UIButton!
    @IBOutlet weak var fromTextTextView: UITextView!
    @IBOutlet weak var toTextTranslateLabel: UILabel!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var fromLangage = LanguageAvailable.language[0] {
        didSet {
            fromLangageButton.setTitle(fromLangage.langage, for: .normal)
            hiddenLabel(true)
        }
    }
    var toLangage = LanguageAvailable.language[0] {
        didSet {
            toLangageButton.setTitle(toLangage.langage, for: .normal)
            hiddenLabel(true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromLangage = LanguageAvailable.language[9]
        toLangage = LanguageAvailable.language[14]
       // hiddenLabel(true)
        activityIndicator.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {                                       
    }

    @IBAction private func resignKeyboard(_ sender: Any) {
        fromTextTextView.resignFirstResponder()
    
    }
    @IBAction private func tappedButtonLanguage(_ sender: Any) {
        performSegue(withIdentifier: "showLanguage", sender: sender)
    
    }
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LangageTableViewController {
            switch sender as? UIButton {
            case toLangageButton:
                destination.fromLanguage = false
            default:
                destination.fromLanguage = true
            }
        }
    }
    @IBAction func tappedTranslateButton(_ sender: Any) {
        Utils.toggleActivityIndicator(button: translateButton, show: true, activityIndicator: activityIndicator)
        guard let fromText = fromTextTextView.text else {
            Utils.toggleActivityIndicator(button: translateButton, show: false, activityIndicator: activityIndicator)
            return present(Utils.presentAlert(message: "Vous devez entrer un text à traduire"), animated: true) {
                Utils.toggleActivityIndicator(button: self.translateButton, show: false, activityIndicator: self.activityIndicator)
            }
        }
        TranslationService.shared.getTranslatedText(text: fromText, toLangage: toLangage) { success, translatedText, error in
            guard success, let translatedText = translatedText, error == nil else {
                return self.present(Utils.presentAlert(message: error?.localizedDescription ?? "Sorry unknow error"), animated: true) {
                    Utils.toggleActivityIndicator(button: self.translateButton, show: false, activityIndicator: self.activityIndicator)
                }
            }
            Utils.toggleActivityIndicator(button: self.translateButton, show: false, activityIndicator: self.activityIndicator)
            self.toTextTranslateLabel.text = translatedText.translatedText
            self.toLangage = LanguageAvailable.detectLanguage(bcpcode47: translatedText.detectedSourceLanguage)
            self.hiddenLabel(false)
            print("La réponse est ")
            print(translatedText.translatedText)
        }
    }
    
    
    
    private func hiddenLabel(_ isHidden : Bool) {
//        UIView.animate(withDuration: 1) {
//            self.toTextTranslateLabel.isHidden = isHidden
//        }
    }
}
