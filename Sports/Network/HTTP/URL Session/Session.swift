//
//  Session.swift
//  BetsApp
//
//  Created by Omar Abdulrahman on 27/03/2024.
//

import Foundation
import Combine

final class Session {
    
    private let networkService: NetworkRequestable
    private var cancellable = Set<AnyCancellable>()
    
    static let shared = Session()
    
    private init(networkService: NetworkRequestable = NetworkService()) {
        self.networkService = networkService
    }
    
    func request<T: Decodable>(from url: URL) -> AnyPublisher<T, Error> {
        let request = URLRequest(url: url)
        return networkService.execute(request: request)
    }
    
    func requestQuery<T: Decodable, E: Encodable>(from url: URL, withQueryParams params: E) -> AnyPublisher<T, Error> {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let encoder = JSONEncoder()
        
        do {
            let encodedData = try encoder.encode(params)
            let queryParams = try JSONSerialization.jsonObject(with: encodedData, options: []) as? [String: Any]
            components?.queryItems = queryParams?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        guard let finalURL = components?.url else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: finalURL)
        return networkService.execute(request: request)
    }

    
    func postRequest<T: Decodable, U: Encodable>(to url: URL, with parameters: U) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let headers = APIHeaders.defaultHeaders()
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return networkService.execute(request: request)
    }
}
