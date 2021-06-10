//
//  ExchangeServiceTest.swift
//  MyBundleTests
//
//  Created by DAGUIN Sébastien on 10/06/2021.
//
@testable import MyBundle
import XCTest

class ExchangeServiceTest: XCTestCase {
    func testGetExhchangeRatePostFailedCallBackError()  {
        let exchangeService = ExchangeService(session : URLSessionFake(data: nil, response: nil, responseError: FakeExchangeService.error))
        exchangeService.getExchangeAmount(toCurrency: "") { success, rate, error in
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            XCTAssertNotNil(error)
        }
    }
    func testGetExhchangeRatePostSuccessCallBack()  {
        let exchangeService = ExchangeService(session : URLSessionFake(data: FakeExchangeService.correctExchange, response: URLResponseFake.responseOK, responseError: FakeExchangeService.error))
        exchangeService.getExchangeAmount(toCurrency: "") { success, rate, error in
            XCTAssertTrue(success)
            XCTAssertNotNil(rate)
            XCTAssertNil(error)
        }
    }
    func testGetExhchangeRatePostFailedCallBackResponseKO()  {
        let exchangeService = ExchangeService(session : URLSessionFake(data: nil, response: URLResponseFake.responseKO, responseError: FakeExchangeService.error))
        exchangeService.getExchangeAmount(toCurrency: "") { success, rate, error in
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            XCTAssertNotNil(error)
        }
    }
}
