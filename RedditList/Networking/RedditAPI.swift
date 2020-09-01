//
//  RedditAPI.swift
//  RedditList
//
//  Created by boqian cheng on 2020-08-12.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import Foundation

enum RedditAPI {
    
    enum RequestMethod: String {
        case get     = "GET"
        case post    = "POST"
        case put     = "PUT"
    }
    
    enum RequestErrors: Error {
        case invalidURL
        case jsonProcessingFailed
        case netConnectionFailed
        case returnedDataNil
    }
    
    // for each endpoind of backend
    case posts(queryParas: [String:String]?, bodyParas: [String:String]?)
    case nextPosts(queryParas: [String:String]?, bodyParas: [String:String]?)
    
    // MARK: - base URL
    var baseURL: String {
        switch self {
        default:
            return "https://www.reddit.com"
        }
        // https://www.reddit.com/r/swift/.json
    }
    
    // MARK: - RequestMethod
    var method: RequestMethod {
        switch self {
        case .posts( _, _):
            return .get
        case .nextPosts( _, _):
            return .get
        }
    }
    
    // MARK: - path string
    var path: String {
        switch self {
        case .posts( _, _):
            return "/r/swift/.json"
        case .nextPosts( _, _):
            return "/r/swift/.json"
        }
    }
    
    // like ...?key=value
    var queryItems: [URLQueryItem]? {
        switch self {
        case .posts(let queryParas, _):
            if let _queryParas = queryParas {
                return _queryParas.map({
                    URLQueryItem(name: $0.key, value: $0.value)
                })
            } else {
                return nil
            }
        case .nextPosts(let queryParas, _):
            if let _queryParas = queryParas {
                return _queryParas.map({
                    URLQueryItem(name: $0.key, value: $0.value)
                })
            } else {
                return nil
            }
        }
    }
    
    // MARK: - Parameters for body
    var bodyParameters: [String:String]? {
        switch self {
        case .posts( _, let bodyParas):
            return bodyParas
        case .nextPosts( _, let bodyParas):
            return bodyParas
        }
    }
    
    // MARK: - URLRequest creating
    func getURLRequest() throws -> URLRequest {
        
        guard var urlComponent = URLComponents(string: baseURL + path) else { throw RequestErrors.invalidURL }
        
        if let query = queryItems {
            urlComponent.queryItems = query
        }
        
        guard let url = urlComponent.url else { throw RequestErrors.invalidURL }
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Parameters
        if let _bodyParameters = bodyParameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: _bodyParameters, options: [])
            } catch {
                throw RequestErrors.jsonProcessingFailed
            }
        }
        return urlRequest
    }
    
    // MARK: - network by urlsession
    func netWorks(request: URLRequest, completion: @escaping (Result42<Data, RequestErrors>) -> Void) {
        
        let defaultSession = URLSession(configuration: .default)
        
        let dataTask = defaultSession.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(Result42.failure(RequestErrors.netConnectionFailed))
                }
            } else if let data = data {
                DispatchQueue.main.async {
                    completion(Result42.success(data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(Result42.failure(RequestErrors.returnedDataNil))
                }
            }
        }
        dataTask.resume()
    }
}


