//
//  WeatherViewController.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 27/04/2021.
//

import UIKit

class WeatherListViewController: UIViewController{
    @IBOutlet weak private var citysTableView: UITableView!
    @IBOutlet weak private var goToFavorisButton: UIButton!
    let citys = City.citys
    
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
extension WeatherListViewController: UITableViewDelegate{
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "ShowWeatherCitySegue", sender: self)
    }
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CityWeatherViewController {
            destination.city = citys[citysTableView.indexPathForSelectedRow!.row].city
            destination.country =  citys[citysTableView.indexPathForSelectedRow!.row].country
        }
    }
}
extension WeatherListViewController : UITableViewDataSource{
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citys.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        var isFavorite = false
        
        for element in FavoriteCity.all {
            if element.nameFavoriteCity == citys[indexPath.row].city {
                isFavorite = true
            }
        }
        
        cell.configure(title: citys[indexPath.row].city, subtitle: citys[indexPath.row].country, imageName:citys[indexPath.row].country,isFavorite: isFavorite)
        return cell
    }
    
    
}
 
