//
//  WeatherService.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 29/04/2021.
//

import Foundation

struct Weather : Codable {
    var main : [String : Double]
}

class WeatherService {
    static var shared = WeatherService()
    private init(){}
    private var task : URLSessionTask?
    private var session = URLSession(configuration: .default)
    
    init(session : URLSession) {
        self.session = session
    }
    
    func getWeather(city : String, fromCountry: String, callback : @escaping (Bool, Error? , Weather?, String?) -> Void) {
        let cityCleaned = Helpers.clearSpaceUrl(city: city)
        let baseUrl = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityCleaned),\(fromCountry)&APPID=1d0946f4656aca3e5708d246a3c7ba87&lang=fr&units=metric")!
        let request = URLRequest(url: baseUrl)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return callback(false, error, nil,nil)
                }
        
                let decoder = JSONDecoder()
                guard let json = String(data: data, encoding: .utf8) else{
                    return callback(false, nil, nil , "String non decode")
                }
                
                print("lE JSONNNN ::: >>>>>>>>>>>>> \(json)")
                guard let product = try? decoder.decode(Weather.self, from: json.data(using: .utf8)!) else{
                    print("Le decodedage n'est pas passer 2")
                    return
                }
                print("Le decodage est passe")
                print("Temperature ressenti ")
                callback(true,nil, product, Helpers.recup(json: json))
            }
        }
        task.resume()
    }
    
}
