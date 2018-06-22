//
//  AppDelegate.swift
//  LetsBuildThatApp-CoreData
//
//  Created by Iven Prillwitz on 21.06.18.
//  Copyright © 2018 Iven Prillwitz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = CustomNavigationController(rootViewController: CompaniesController())

        return true
    }
}

