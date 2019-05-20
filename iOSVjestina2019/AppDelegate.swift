//
//  AppDelegate.swift
//  iOSVjestina2019
//
//  Created by FIVE on 03/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let user = UserDefaults.standard.object(forKey: "token") ?? nil
        let viewController = QuizzesViewController(viewModel: QuizzesViewModel())
        var navigationController = UINavigationController(rootViewController: viewController)
        if user == nil {
            navigationController.pushViewController(LoginViewController(), animated: false)
            navigationController.topViewController?.navigationItem.hidesBackButton = true
        }
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

