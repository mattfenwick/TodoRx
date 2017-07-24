//
//  AppDelegate.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/18/17.
//  Copyright © 2017 mf. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var todoFlowController: TodoFlowController? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window

        let fc = TodoFlowController(interactor: TodoFlowDefaultInteractor())
        self.window?.rootViewController = UINavigationController(rootViewController: fc.viewController)
        todoFlowController = fc

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
