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
    let weatherService = WeatherService.shared
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        showWeather()
        cityNavigationItem.title = city
        if Helpers.checkElementIsFavorite(cityName: city){
            Utils.diseableButtonWithAnimation(animation: false, button: addFavorisButton)
            
        }
        
    }
    private func showWeather() {
        WeatherService.shared.getWeather(city: city, fromCountry: country) { success, weather, error  in
            guard success, error == nil , let weather = weather else {
                return self.present(KitUtils.presentAlert(message: error?.localizedDescription ?? "Sorry Unknow Error"), animated: true, completion: nil)
            }
            let tempsToShow = WeatherUtils.tempsToShow(weather: weather)
            Utils.uptdateTemperatureImage(temps: Double(tempsToShow), temperatureImageView: self.temperatureImageView)
            Utils.uptdateView(temps: "\(tempsToShow)°", description: weather.weather[0].description.capitalized , tempsLabel: self.temperatureLabel, descriptionLabel : self.descriptionLabel)
            self.imageCityImageView.image = UIImage(named: self.country )
        }
    }
    @IBAction private func tappedAddfavoris(_ sender: UIButton) {
        let favoriteCity = FavoriteCity(context: AppDelegate.viewContext)
        favoriteCity.nameOfFlag = country
        favoriteCity.nameFavoriteCity = city
        try? AppDelegate.viewContext.save()
        if Helpers.checkElementIsFavorite(cityName: city){
            Utils.diseableButtonWithAnimation(animation: true, button: addFavorisButton)
            
        }
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
