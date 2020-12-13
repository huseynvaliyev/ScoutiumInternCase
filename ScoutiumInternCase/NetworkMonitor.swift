//
//  NetworkMonitor.swift
//  ScoutiumInternCase
//
//  Created by Huseyn Valiyev on 13.12.2020.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public var isConneted : Bool = false
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {path in
            self.isConneted = path.status == .satisfied
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
}
