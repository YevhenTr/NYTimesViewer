//
//  Networking.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 19.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import Foundation

import Alamofire

public enum HTTP {

    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}

struct Networking {

    // MARK: - Subtypes
    
    private enum Constant {
        
        static let timeout = TimeInterval(40)
    }
    
    // MARK: - Properties
        
    private let decoder = JSONDecoder()
    
    private let defaultURLComponents: URLComponents
    private let defaultURLQueryItems: [URLQueryItem]
    private let defaultHTTPHeader: [String: String]
    
    // MARK: - Init and Deinit
    
    init(api: NetworkAPI) {
        self.defaultURLComponents = api.defaultURLComponents
        self.defaultURLQueryItems = api.defaultURLQueryItems
        self.defaultHTTPHeader = api.defaultHTTPHeader
    }

    // MARK: - Public
    
    public func createRequest(method: HTTP.Method = .get,
                              queryItems: [URLQueryItem] = [],
                              path: String = "",
                              body: Data? = nil,
                              parameters: [String: String] = [:]) -> URLRequest?
    {
        var components = self.defaultURLComponents
        components.queryItems = self.defaultURLQueryItems + queryItems
        components.path = path
        
        guard let url = components.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.timeoutInterval = Constant.timeout
        
        let httpHeader = self.defaultHTTPHeader
        httpHeader.append(parameters)
        httpHeader.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        return request
    }
            
    public func send<Response: Decodable>(request: URLRequest?,
                                          completion: @escaping Handler<Result<Response, Error>>)
    {
        guard let request = request else {
            self.errorHandling(error: NetworkError.invalidURLRequest, completion: completion)
            
            return
        }
        
        AF.request(request)
            .validate(statusCode: 200..<400)
            .response { response in
                if let error = response.error {
                    self.errorHandling(error: error, completion: completion)
                } else {
                    self.responseHandling(response: response, completion: completion)
                }
        }
    }
    
    // MARK: - Private
    
    private func errorHandling<Response: Decodable>(error: Error,
                                                    completion: @escaping Handler<Result<Response, Error>>)
    {
        completion(.failure(error))
    }
    
    private func responseHandling<Response: Decodable>(response: AFDataResponse<Data?>,
                                                       completion: @escaping Handler<Result<Response, Error>>)
    {
        if let data = response.data {
            if let model = try? self.decoder.decode(Response.self, from: data) {
                completion(.success(model))
            } else {
                debugPrint(String(decoding: data, as: UTF8.self))
                completion(.failure(ParserError.invalidData))
            }
        } else {
            completion(.failure(ParserError.missingData))
        }
    }
}
