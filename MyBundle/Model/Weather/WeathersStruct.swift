//
//  WeathersStruct.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 14/06/2021.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
}

struct Weather: Decodable {
    let main: String
    let description: String
}

struct Main: Decodable {
    let temp: Double
}
