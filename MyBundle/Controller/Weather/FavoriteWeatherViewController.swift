//
//  FavoriteWeatherViewController.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 30/04/2021.
//

import UIKit
import CoreData


class FavoriteWeatherViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var favoriteContryPickerView: UIPickerView!
    @IBOutlet weak private var removeButton: UIButton!
    private let weatherService = WeatherService.shared
    
    @IBOutlet weak private var temperatureImageView: UIImageView!
    private var favoriteCity = FavoriteCity.all {
        willSet {
            if newValue.count == 0 {
                navigationController?.popViewController(animated: true)
            }
        }
    }
    @IBOutlet weak var imageCityImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWeather()
    }
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return favoriteCity.count
    }
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return favoriteCity[row].nameFavoriteCity
    }
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        showWeather()
    }
    @IBAction private func removeFavoriCity(_ sender: Any) {
        guard !favoriteCity.isEmpty else {
            removeButton.isEnabled = true
            return
        }
        let indexToCity = favoriteContryPickerView.selectedRow(inComponent: 0)
        if !favoriteCity.isEmpty {
            favoriteCity.remove(at: indexToCity)
            favoriteContryPickerView.reloadAllComponents()
            AppDelegate.viewContext.delete(FavoriteCity.all[indexToCity])
            try? AppDelegate.viewContext.save()
        }
        else{
            removeButton.isEnabled = false
        }
    }
    private func showWeather() {
        
        let indexToCity = favoriteContryPickerView.selectedRow(inComponent: 0)
        let toCity = FavoriteCity.all[indexToCity].nameFavoriteCity
        let toCountry = FavoriteCity.all[indexToCity].nameOfFlag
        weatherService.getWeather(city: toCity!, fromCountry: toCountry!) { success, weather,  error in
            guard success, error == nil, let weather = weather else {
                return self.present(KitUtils.presentAlert(message: error?.localizedDescription ?? "Unknow error"), animated: true, completion: nil)
            }
            let tempsToShow = WeatherUtils.tempsToShow(weather: weather)
            Utils.uptdateTemperatureImage(temps: Double(tempsToShow), temperatureImageView: self.temperatureImageView)
            Utils.uptdateView(temps: "\(tempsToShow)°", description: weather.weather[0].description.capitalized, tempsLabel: self.temperatureLabel, descriptionLabel : self.descriptionLabel)
            self.imageCityImageView.image = UIImage(named: toCountry ?? "cloud")
        }
    }
}
