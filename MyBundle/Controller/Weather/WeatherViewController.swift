//
//  WeatherViewController.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 27/04/2021.
//

import UIKit

class WeatherViewController: UIViewController{
    @IBOutlet weak private var citysTableView: UITableView!
    @IBOutlet weak private var goToFavorisButton: UIButton!
    override internal func viewDidLoad() {
        super.viewDidLoad()
        goToFavorisButton.isEnabled = !FavoriteCity.all.isEmpty
        
    }
    override internal func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        citysTableView.reloadData()
        goToFavorisButton.isEnabled = !FavoriteCity.all.isEmpty
    }
}
extension WeatherViewController: UITableViewDelegate{
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "ShowWeatherCitySegue", sender: self)
    }
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CityWeatherViewController {
            destination.city = City.shared.city[citysTableView.indexPathForSelectedRow!.row].city
            destination.country =  City.shared.city[citysTableView.indexPathForSelectedRow!.row].country 
        }
    }
}
extension WeatherViewController : UITableViewDataSource{
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return City.shared.city.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        var isFavorite = false
        
        for element in FavoriteCity.all {
            if element.nameFavoriteCity == City.shared.city[indexPath.row].city {
                isFavorite = true
            }
        }
        
        cell.configure(title: City.shared.city[indexPath.row].city, subtitle: City.shared.city[indexPath.row].country, imageName:City.shared.city[indexPath.row].country,isFavorite: isFavorite)
        return cell
    }
    
    
}
 
