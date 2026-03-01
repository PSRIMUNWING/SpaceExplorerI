//
//  AppDelegate.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 1/3/2569 BE.
//

import UIKit

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        let naviationController = UINavigationController(rootViewController: HomeViewController()) //to have the navigation bar
//        window.rootViewController = naviationController
//        window.makeKeyAndVisible()
//        self.window = window
//        
//        return true
//    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeVC = storyboard.instantiateInitialViewController() as! HomeViewController
        let navigationController = UINavigationController(rootViewController: homeVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}


