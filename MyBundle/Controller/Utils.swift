//
//  Function.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 30/04/2021.
//

import Foundation
import UIKit

struct Utils {
    static func toggleActivityIndicator(button : UIButton, show: Bool,activityIndicator : UIActivityIndicatorView ) {
        button.isHidden = show
        activityIndicator.isHidden = !show
        activityIndicator.startAnimating()
    }
    static func uptdateView(temps : String, description : String,tempsLabel: UILabel, descriptionLabel : UILabel ) {
        print("Tentative de uptdate la vue ")
        print(description)
        tempsLabel.text = temps
        descriptionLabel.text = cleanDescription(description: description)
    }
    static func cleanDescription(description : String) -> String {
        var descriptionArray = Array(description)
        descriptionArray.remove(at: description.count - 1)
        descriptionArray.remove(at: 0)
        descriptionArray[0] = descriptionArray[0].uppercased().first!
        return String(descriptionArray)
    }
    static func uptdateTemperatureImage(temps : Double,temperatureImageView : UIImageView) {
        switch temps {
        case  0...10 :
            temperatureImageView.image = #imageLiteral(resourceName: "hiver")
        case 10...30 :
            temperatureImageView.image = #imageLiteral(resourceName: "sun")
        case 30...50:
            temperatureImageView.image = #imageLiteral(resourceName: "hotsun")
        default:
            break
        }
    }
    static func presentAlert(message : String) -> UIAlertController {
        let alertVc = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertVc
    }
    static private func disableButton(button : UIButton) {
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    static func diseableButtonWithAnimation(animation : Bool, button : UIButton) {
        if animation {
            UIView.animate(withDuration: 1.5) {
                button.shake()
                disableButton(button: button)
            }
        }else {
            disableButton(button: button)
        }
    }
    static func isFromEur() -> Bool {
       let userDefault = UserDefaults.standard
       return userDefault.bool(forKey: "fromEur")
   }
}

