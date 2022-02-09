//
//  AppDelegate.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 05/02/2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        NetworkMonitor.shared.startMonitoring()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        NetworkMonitor.shared.stopMonitoring()
    }

}

