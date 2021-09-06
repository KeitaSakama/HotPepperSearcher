//
//  AppDelegate.swift
//  HPApp
//
//  Created by 坂馬啓太 on 2021/08/29.
//

import UIKit
import IQKeyboardManagerSwift

@main

class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        return true
    }
}

