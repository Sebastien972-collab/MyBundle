//
//  ExchangeService.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 27/04/2021.
//

import Foundation

class ExchangeService {
    static var shared = ExchangeService()
    private init(){}
    private let baseUrl = URL(string: "https://data.fixer.io/api/latest")!
    private var task : URLSessionTask?
    var exchangeAmount : String = " "
    
    
     func getExchangeAmount(fromCurrency: String, toCurrency: String, callback: @escaping (Bool, Data?) -> Void){
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "POST"
        let body = "?access_key=91d269752abd205689d4d4c31fff86c6&base=\(fromCurrency)&symbols\(toCurrency)"
        request.httpBody = body.data(using: .utf8)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response , error in
            guard let data = data, error == nil else {
                print("Ya un probleme seb ici Erreur = \(error!)")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                print("Status code pas valide ")
                return
            }
            guard let reponseJSON = try? JSONDecoder().decode([String : String].self, from : data) else {
                print("Probleme decodade JSON")
                return
            }
            guard let rate = reponseJSON["rate"] else{
                print("Pas de taux obtenue")
                return
            }
            print(rate)
            
        }
        task.resume()
        
        
        
    }
}
