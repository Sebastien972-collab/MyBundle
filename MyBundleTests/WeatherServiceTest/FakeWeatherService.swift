//
//  FakeWeatherService.swift
//  MyBundleTests
//
//  Created by DAGUIN Sébastien on 01/06/2021.
//

import Foundation
class FakeWeatherService {
    class WeatherError : Error {}
    static let error = WeatherError()
    
    static var weatherCorrect : Data {
        let bundle = Bundle(for: FakeWeatherService.self)
        let url = bundle.url(forResource: "FakeWeather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let incorrectWeatherData = "erreur".data(using: .utf8)!
    
}
