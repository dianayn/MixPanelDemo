//
//  AppDelegate.swift
//  MixpanelDemo
//
//  Created by Diana Duan on 8/2/20.
//  Copyright © 2020 diana. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window: UIWindow = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window.rootViewController = ViewController()
        window.makeKeyAndVisible()

        return true
    }


}

