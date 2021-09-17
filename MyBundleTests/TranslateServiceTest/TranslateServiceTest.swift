//
//  TranslateServiceTest.swift
//  TranslateServiceTest
//
//  Created by DAGUIN Sébastien on 21/07/2021.
//
@testable import MyBundle
import XCTest

class TranslateServiceTest: XCTestCase {
    
    func testGetTextToTranslatePostFailed() {
        let translateService = TranslationService(session: URLSessionFake(data: nil, response: nil, responseError: FakeTranslateService.error))
        translateService.getTranslatedText(source: Language.defaultAutoLanguage, text: "", toLangage: LanguageAvailable.language[0]) { success, textTranslated, error in
            XCTAssertFalse(success)
            XCTAssertNil(textTranslated)
            XCTAssertNotNil(error)
        }
    }
    func testGetTextToTranslateRatePostSuccessCallBack()  {
        let translateService = TranslationService(session: URLSessionFake(data: FakeTranslateService.correctExchange, response: URLResponseFake.responseOK, responseError: FakeTranslateService.error))
        translateService.getTranslatedText(source: .defaultAutoLanguage, text: "", toLangage: LanguageAvailable.language[0]) { success, textTranslated, error in
            XCTAssertTrue(success)
            XCTAssertNotNil(textTranslated)
            XCTAssertNil(error)
        }
    }
    func testGetTextToTransaltePostFailedCallBackResponseKO()  {
        let translateService = TranslationService(session: URLSessionFake(data: nil, response: URLResponseFake.responseKO, responseError: FakeTranslateService.error))
        translateService.getTranslatedText(source: .defaultAutoLanguage, text: "", toLangage: LanguageAvailable.language[0]) { success, textTranslated, error in
            XCTAssertFalse(success)
            XCTAssertNil(textTranslated)
            XCTAssertNotNil(error)
        }
    }
}
