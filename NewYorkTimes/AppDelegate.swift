//
//  AppDelegate.swift
//  NewYorkTimes
//
//  Created by levantAJ on 11/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let homeVC = navigationController.topViewController as! HomeViewController
        homeVC.viewModel = HomeViewModelFactory.create()
        window?.rootViewController = navigationController
        return true
    }
}

