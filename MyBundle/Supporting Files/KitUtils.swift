//
//  Utils.swift
//  FirstSDF
//
//  Created by DAGUIN Sébastien on 13/07/2021.
//

import Foundation
import UIKit

public struct KitUtils {
    public init() {}
    public static func getImage(urlString: String?) -> UIImage {
        guard let urlString = urlString else { return UIImage(systemName: "globe")! }
        guard let url = URL(string: urlString) else {
            let image = UIImage(systemName: "globe")!
            return image
        }
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return UIImage(systemName: "globe")!
    }
    public static func clearWhitespace(string : String) -> String {
        let clearString = string.filter {!$0.isWhitespace}
        return clearString
    }
    public static func arrayStringToString(ingredients : [String]) -> String {
        var ingredientsString = ""
        for ingredient in ingredients {
            let clearIngredient = ingredient.trimmingCharacters(in: .whitespaces)
            ingredientsString.append(",\(clearIngredient)")
        }
        return ingredientsString
    }
    public static func toggleActivityIndicator(button : UIButton, show: Bool ,activityIndicator : UIActivityIndicatorView ) {
        button.isHidden = show
        activityIndicator.isHidden = !show
        activityIndicator.startAnimating()
    }
    public static func presentAlert(message : String) -> UIAlertController {
        let alertVc = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertVc
    }
}
