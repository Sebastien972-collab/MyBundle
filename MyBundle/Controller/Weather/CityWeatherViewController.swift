//
//  CityWeatherViewController.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 02/05/2021.
//

import UIKit

class CityWeatherViewController: UIViewController {
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var addFavorisButton: UIButton!
    @IBOutlet weak private var temperatureImageView: UIImageView!
    @IBOutlet weak private var cityNavigationItem: UINavigationItem!
    @IBOutlet weak private var imageCityImageView: UIImageView!
    internal var city = " "
    internal var country = " "
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        showWeather()
        cityNavigationItem.title = city
        if checkElementIsFavorite(cityName: city){
            Utils.diseableButtonWithAnimation(animation: false, button: addFavorisButton)
            
        }
        
    }
    private func showWeather() {
        WeatherService.shared.getWeather(city: city, fromCountry: country) { success, error,  weather , description  in
            guard success, error == nil , let weather = weather, let description = description else {
                return self.present(Utils.presentAlert(message: error!.localizedDescription), animated: true, completion: nil)
            }
            guard let temp = weather.main["temp"] else {
                self.present(Utils.presentAlert(message: "Error temp not found "), animated: true, completion: nil)
                return
            }
            let tempsToShow = Double(round(temp))
            Utils.uptdateTemperatureImage(temps: tempsToShow, temperatureImageView: self.temperatureImageView)
            Utils.uptdateView(temps: "\(Int(tempsToShow))°", description: description, tempsLabel: self.temperatureLabel, descriptionLabel : self.descriptionLabel)
            self.imageCityImageView.image = UIImage(named: self.country )
        }
    }
    @IBAction private func tappedAddfavoris(_ sender: UIButton) {
        let favoriteCity = FavoriteCity(context: AppDelegate.viewContext)
        favoriteCity.nameOfFlag = country
        favoriteCity.nameFavoriteCity = city
        try? AppDelegate.viewContext.save()
        if checkElementIsFavorite(cityName: city){
            Utils.diseableButtonWithAnimation(animation: true, button: addFavorisButton)
            
        }
    }
    private func checkElementIsFavorite(cityName : String) -> Bool {
        for city in FavoriteCity.all {
            if city.nameFavoriteCity == cityName {
                return true
            }
        }
        return false
    }
    
    
}
extension UIView{
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y - 5)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        
        let toPoint =  CGPoint(x: center.x + 5, y: center.y + 5)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
        
        
    }
}
