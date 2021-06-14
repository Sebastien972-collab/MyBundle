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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
        WeatherService.shared.getWeather(city: toCity!, fromCountry: toCountry!) { success, error,  weather in
            guard success, error == nil, let weather = weather else {
                return self.present(Utils.presentAlert(message: error!.localizedDescription), animated: true, completion: nil)
            }
            let tempsToShow = Double(round(weather.main.temp))
            Utils.uptdateTemperatureImage(temps: tempsToShow, temperatureImageView: self.temperatureImageView)
            Utils.uptdateView(temps: "\(Int(tempsToShow))°", description: weather.weather.description, tempsLabel: self.temperatureLabel, descriptionLabel : self.descriptionLabel)
            self.imageCityImageView.image = UIImage(named: toCountry ?? "cloud")
        }
    }
}
