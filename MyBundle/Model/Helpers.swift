//
//  Helpers.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 10/06/2021.
//

import Foundation

struct Helpers {
    
    static func checkElementIsFavorite(cityName : String) -> Bool {
        for city in FavoriteCity.all {
            if city.nameFavoriteCity == cityName {
                return true
            }
        }
        return false
    }
}
