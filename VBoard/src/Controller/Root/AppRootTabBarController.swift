//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit

protocol AppRootTabBarControllerProtocol: UITabBarController {}

class AppRootTabBarController: UITabBarController, AppRootTabBarControllerProtocol {
    // MARK: - Type Aliases

    typealias Factory = ViewControllerFactory

    // MARK: - Properties

    private let factory: Factory

    // MARK: - Initializer

    init(factory: Factory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }

    // swiftlint:disable:next unavailable_function
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchViewController = factory.makeSearchEntryViewController(with: nil)

        searchViewController.tabBarItem = UITabBarItem(title: L10n.Tabbar.search, image: nil, tag: 0)

        self.viewControllers = [UINavigationController(rootViewController: searchViewController)]
    }
}
