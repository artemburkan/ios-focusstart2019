//
//  AppDelegate.swift
//  CarCatalog
//
//  Created by Artyom Burkan on 27/04/2019.
//  Copyright © 2019 Artyom Burkan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let carListViewController = CarListViewController()
        let navigationController = UINavigationController(rootViewController: carListViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }


}

