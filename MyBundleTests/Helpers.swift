//
//  Helpers.swift
//  MyBundleTests
//
//  Created by DAGUIN Sébastien on 10/06/2021.
//

import Foundation
class URLResponseFake {
    static let responseOK = HTTPURLResponse(url: URL(string: "htppp://fakeurl")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "htppp://fakeurl")!, statusCode: 500, httpVersion: nil, headerFields: nil)
}
