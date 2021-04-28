//
//  ExchangeService.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 27/04/2021.
//

import Foundation
struct RateJsonDecode : Codable {
    var base : String
    var date : String
    var rates : [String : Double]
    
}

class ExchangeService {
    static var shared = ExchangeService()
    private init(){}
    private var task : URLSessionTask?
    
     func getExchangeAmount(toCurrency: String, callback: @escaping (Bool, RateJsonDecode) -> Void){
        let baseUrl = URL(string: "http://data.fixer.io/api/latest?access_key=91d269752abd205689d4d4c31fff86c6&base=EUR&symbols=\(toCurrency)")!
        var request = URLRequest(url: baseUrl)
//        request.httpBody = body.data(using: .utf8)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response , error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Ya un probleme seb ici Erreur = \(error!)")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    print("Status code pas valide ")
                    return
                }
                let decoder = JSONDecoder()
                guard let json = String(data: data, encoding: .utf8) else{
                    print("String non decoder ")
                    return
                }
                print("lE JSONNNN ::: >>>>>>>>>>>>> \(json)")
                guard let product = try? decoder.decode(RateJsonDecode.self, from: json.data(using: .utf8)!) else{
                    print("Le decodage JSON n'est pas passe")
                    return
                }
                print("Le decodage est passe")
                print("La base \(product.base)")
                print("Rates")
                print(product.rates[toCurrency]!)
                callback(true, product)
            }
            
        }
        task.resume()
        
        
        
    }
}
