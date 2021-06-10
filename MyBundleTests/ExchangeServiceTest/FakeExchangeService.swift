//
//  FakeExchangeServie.swift
//  MyBundleTests
//
//  Created by DAGUIN Sébastien on 10/06/2021.
//

import Foundation
class FakeExchangeService {
    class ExchangeError: Error {}
    static let error = ExchangeError()
    static var correctExchange: Data {
        let bundle = Bundle(for: FakeExchangeService.self)
        let url = bundle.url(forResource: "FakeExchangeData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let incorrectWeeatherData = "ereur".data(using: .utf8)!
    
}
