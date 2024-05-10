//
//  NetworkChecker.swift
//  BetsApp
//
//  Created by Omar Abdulrahman on 08/04/2024.
//

import Foundation
import Combine
import Network

class NetworkConnectivityChecker {
    
    private let monitor = NWPathMonitor()
    private let isConnectedSubject = CurrentValueSubject<Bool, Never>(false)
    
    var isConnectedPublisher: AnyPublisher<Bool, Never> {
        return isConnectedSubject.eraseToAnyPublisher()
    }
    
    init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            let isConnected = path.status == .satisfied
            self?.isConnectedSubject.send(isConnected)
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
}
