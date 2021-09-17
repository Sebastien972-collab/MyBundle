//
//  URLSessionFake.swift
//  MyBundleTests
//
//  Created by DAGUIN Sébastien on 10/06/2021.
//

import Foundation
class URLSessionFake : URLSession {
    var data : Data?
    var response : URLResponse?
    var responseError : Error?
    
    
    init( data : Data?, response : URLResponse?, responseError : Error?) {
        self.data = data
        self.response = response
        self.responseError = responseError
    }
    
    
    
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
        task.responseError = responseError
        task.urlResponse = response
        return task
        
    }
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
        task.responseError = responseError
        task.urlResponse = response
        return task
    }
    
}
class URLSessionDataTaskFake: URLSessionDataTask {
    var completionHandler : ((Data?, URLResponse?, Error?) -> Void)?
    
    var data : Data?
    var urlResponse : URLResponse?
    var responseError : Error?
    
    
    
    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }
    override func cancel() {}
}
