//
//  WeatherService.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 29/04/2021.
//

import Foundation

class WeatherService {
    static var shared = WeatherService()
    private init(){}
    private var task : URLSessionTask?
    private var session = URLSession(configuration: .default)
    
    init(session : URLSession) {
        self.session = session
    }
    
    func getWeather(city : String, fromCountry: String, callback : @escaping (Bool, WeatherData?, Error?  ) -> Void) {
        let cityCleaned = Helpers.clearSpaceUrl(city: city)
        let baseUrl = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityCleaned),\(fromCountry)&APPID=1d0946f4656aca3e5708d246a3c7ba87&lang=fr&units=metric")!
        let request = URLRequest(url: baseUrl)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return callback(false, nil, error)
                }
        
                let decoder = JSONDecoder()
                do {
                    let product = try decoder.decode(WeatherData.self, from: data)
                    callback(true, product, nil)
                } catch  {
                    callback(false, nil, error)
                }
            }
        }
        task.resume()
    }
    
}
