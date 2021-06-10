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
    
      func getExchangeAmount(toCurrency: String, callback: @escaping (Bool, RateJsonDecode?, Error?) -> Void){
        let baseUrl = URL(string: "http://data.fixer.io/api/latest?access_key=91d269752abd205689d4d4c31fff86c6&base=EUR&symbols=\(toCurrency)")!
        let request = URLRequest(url: baseUrl)
//        request.httpBody = body.data(using: .utf8)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response , error in
            DispatchQueue.main.async {
                guard let data = data, error == nil , let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil, error)
                    return
                }
                let decoder = JSONDecoder()
                guard let json = String(data: data, encoding: .utf8) else{
                    return
                }
                print("lE JSONNNN ::: >>>>>>>>>>>>> \(json)")
                do {
                    let product = try decoder.decode(RateJsonDecode.self, from: json.data(using: .utf8)!)
                    print(product.rates[toCurrency]!)
                    print("Le decodage est passe")
                    print("La base \(product.base)")
                    print("Rates")
                    callback(true, product , nil)
                }catch {
                    callback(false,nil, error)
                }

               
                
            }
            
        }
        task.resume()
    }
}
