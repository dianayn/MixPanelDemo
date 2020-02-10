//
//  AppDelegate.swift
//  MixpanelDemo
//
//  Created by Diana Duan on 8/2/20.
//  Copyright © 2020 diana. All rights reserved.
//  https://www.appcoda.com/mixpanel-integration/

import UIKit
import Mixpanel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window: UIWindow = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window.rootViewController = ViewController()
        window.makeKeyAndVisible()

        IntialiseMixpanel()

        return true
    }

    func IntialiseMixpanel() {
        Mixpanel.initialize(token: "6b16a6fa951c5d1e28819f68d22cdf17")
        Mixpanel.mainInstance().track(event: "App launched")
    }

}

