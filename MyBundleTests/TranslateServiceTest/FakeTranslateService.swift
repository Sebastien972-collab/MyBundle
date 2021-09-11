//
//  FakeTranslateService.swift
//  FakeTranslateService
//
//  Created by DAGUIN Sébastien on 21/07/2021.
//

import Foundation

class FakeTranslateService {
    class TranslateError : Error {}
    static let error = TranslateError()
    static var correctExchange: Data {
        let bundle = Bundle(for: FakeTranslateService.self)
        let url = bundle.url(forResource: "FakeTranslateData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let incorrectWeeatherData = "ereur".data(using: .utf8)!
}
