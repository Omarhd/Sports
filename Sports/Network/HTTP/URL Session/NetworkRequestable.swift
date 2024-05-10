//
//  NetworkRequestable.swift
//  BetsApp
//
//  Created by Omar Abdulrahman on 27/03/2024.
//

import Foundation
import Combine

protocol NetworkRequestable {
    func execute<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error>
}
