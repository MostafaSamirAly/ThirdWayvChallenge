//
//  NetworkReachability.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 07/02/2022.
//

import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    var netOn: Bool = true
 
    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }
 
    func startMonitoring() {
        self.monitor.pathUpdateHandler = { [weak self] path in
            self?.netOn = path.status == .satisfied
        }
    }
 
    func stopMonitoring() {
        self.monitor.cancel()
    }
}
