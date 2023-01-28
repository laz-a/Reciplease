//
//  MockURLProtocol.swift
//  RecipleaseTests
//
//  Created by laz on 22/01/2023.
//

import Foundation

import Foundation

final class MockURLProtocol: URLProtocol {
    
    enum ResponseType {
        case error(Error)
        case success(response: HTTPURLResponse, data: Data?)
    }
    static var responseType: ResponseType!
    
    private lazy var session: URLSession = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    private(set) var activeTask: URLSessionTask?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }
    
    override func startLoading() {
        activeTask = session.dataTask(with: request.urlRequest!)
        activeTask?.cancel()
    }
    
    override func stopLoading() {
        activeTask?.cancel()
    }
}

// MARK: - URLSessionDataDelegate
extension MockURLProtocol: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        client?.urlProtocol(self, didLoad: data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        switch MockURLProtocol.responseType {
        case .error(let error)?:
            client?.urlProtocol(self, didFailWithError: error)
        case .success(let response, let data)?:
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
        default:
            break
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
}

extension MockURLProtocol {
    
    enum MockError: Error {
        case none
    }
    
    static func responseWithFailure() {
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.error(MockError.none)
    }
    
    static func responseWithStatusCode(code: Int) {
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.success(response: HTTPURLResponse(url: URL(string: "http://any.com")!, statusCode: code, httpVersion: nil, headerFields: nil)!, data: nil)
    }
    
    static func responseWithValidData() {
        var data: Data? {
            let bundle = Bundle(for: MockURLProtocol.self)
            // Read json from Weather.json
            let url = bundle.url(forResource: "recipeData", withExtension: "json")
            if let data = try? Data(contentsOf: url!) {
                return data
            }
            return nil
        }
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.success(response: HTTPURLResponse(url: URL(string: "http://any.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!, data: data)
    }
}
