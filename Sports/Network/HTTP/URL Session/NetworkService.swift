//
//  Session.swift
//  BetsApp
//
//  Created by Omar Abdulrahman on 27/03/2024.
//

import Foundation
import Combine

final class NetworkService: NetworkRequestable {
    
    private let session: URLSession
    private let connectivityChecker: NetworkConnectivityChecker
    
    init(session: URLSession = URLSession(configuration: .default), connectivityChecker: NetworkConnectivityChecker = NetworkConnectivityChecker()) {
        self.session = session
        self.connectivityChecker = connectivityChecker
    }
    
    func execute<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error> {
        return connectivityChecker.isConnectedPublisher
            .flatMap { isConnected -> AnyPublisher<T, Error> in
                guard isConnected else {
                    return Fail(error: NetworkError.noInternetConnection).eraseToAnyPublisher()
                }
                return self.session.dataTaskPublisher(for: request)
                    .tryMap { data, response in
                        guard let response = response as? HTTPURLResponse else { throw RequestError.noResponse }
                        switch response.statusCode {
                        case 200...299:
                            return data
                        case 400:
                            throw RequestError.badRequest
                        case 401:
                            throw RequestError.unauthorized
                        case 422:
                            throw RequestError.decode(data)
                        case 404:
                            throw RequestError.notFound
                        default:
                            throw RequestError.unknown
                        }
                    }
                    .decode(type: T.self, decoder: JSONDecoder())
                    .eraseToAnyPublisher()
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
