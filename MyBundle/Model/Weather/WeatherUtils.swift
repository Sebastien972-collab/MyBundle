//
//  WeatherUtils.swift
//  WeatherUtils
//
//  Created by DAGUIN Sébastien on 21/07/2021.
//

import Foundation
struct WeatherUtils {
    
    static func tempsToShow(weather : WeatherData) -> Int {
        let tempsToShow = KitSdHelpers.roundedValue(value: weather.main.temp)
        return KitSdHelpers.integerConvert(value: tempsToShow)
    }
    
}
