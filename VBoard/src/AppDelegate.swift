//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        if let window = window {
            let container = DependencyContainer()
            let rootViewController = AppRootViewController(factory: container)
            window.backgroundColor = .white
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
        }

        return true
    }
}
