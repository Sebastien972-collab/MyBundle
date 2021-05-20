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
    }
    private func showWeather() {
        WeatherService.shared.getWeather(city: city, fromCountry: country) { success, weather , description in
            if success{
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
    }
    @IBAction private func tappedAddfavoris(_ sender: UIButton) {
        let favoriteCity = FavoriteCity(context: AppDelegate.viewContext)
        favoriteCity.nameOfFlag = country
        favoriteCity.nameFavoriteCity = city
        try? AppDelegate.viewContext.save()
    }
}
