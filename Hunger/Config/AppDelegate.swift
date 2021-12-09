//
//  AppDelegate.swift
//  Hunger
//
//  Created by Sebastian Mejia on 1/10/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        setUpNavigationBar()
        prepareUIWindow()
        
        return true
    }
    
    private func setUpNavigationBar() {
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
    }
    
    private func prepareUIWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(
            rootViewController: StartMenuViewController()
        )
        window?.makeKeyAndVisible()
        
    }
    
}
