//
//  AppDelegate.swift
//  Greencopper Spotify Test
//
//  Created by Wojtek Frątczak on 2017-09-17.
//  Copyright © 2017 Wojtek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if !LoginManager.shared.isLogged {
            self.window?.rootViewController = LoginViewController()
            self.window?.makeKeyAndVisible()
        } else {
            LoginManager.shared.prepare()
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return LoginManager.shared.handled(url: url)
    }

}

