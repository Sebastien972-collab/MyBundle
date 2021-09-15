//
//  TranslateService.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 05/07/2021.
//

import Foundation
let apiKey = "AIzaSyBySClj_kCZ-48sPyc00CHTOMiMCQ4ZlKc"

class TranslationService {
    static var shared = TranslationService()
    private init(){}
    private var task : URLSessionTask?
    private var session = URLSession(configuration: .default)
    init(session : URLSession) {
        self.session = session
    }
    func getTranslatedText(source : Language, text : String, toLangage: Language, callback: @escaping (Bool, TextTranslated?, Error?) -> Void){
        let clearText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        var url : String {
            if source.script == .auto  {
                return "https://translation.googleapis.com/language/translate/v2?key=AIzaSyBySClj_kCZ-48sPyc00CHTOMiMCQ4ZlKc&q=\(clearText.utf8)&target=\(toLangage.bcpcode47)"
            }else {
                return "https://translation.googleapis.com/language/translate/v2?key=AIzaSyBySClj_kCZ-48sPyc00CHTOMiMCQ4ZlKc&q=\(clearText.utf8)&source=\(source.bcpcode47)&target=\(toLangage.bcpcode47)"
            }
        }
        
        guard let baseUrl = URL(string: url) else {
            return callback(false, nil, nil)
        }
        print(baseUrl)
        let request = URLRequest(url: baseUrl)
        let task = session.dataTask(with: request) { data, response , error in
            DispatchQueue.main.async {
                guard let data = data, error == nil , let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil, error)
                    return
                }
                let decoder = JSONDecoder()

                do {
                    let product = try decoder.decode(TranslateData.self, from: data)
                    callback(true, product.data.translations[0] , nil)
                }catch {
                    callback(false,nil, error)
                }
            }
        }
        task.resume()
    }
}
