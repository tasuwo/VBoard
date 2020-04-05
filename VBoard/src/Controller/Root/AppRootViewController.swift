//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit

protocol AppRootViewControllerProtocol: UIViewController {}

class AppRootViewController: UIViewController, AppRootViewControllerProtocol {
    // MARK: - Type Aliases

    typealias Factory = ViewControllerFactory

    // MARK: - Properties

    private let factory: Factory
    private let rootTabBarController: AppRootTabBarControllerProtocol

    // MARK: - Initializer

    init(factory: Factory) {
        self.factory = factory
        self.rootTabBarController = factory.makeAppRootTabBarController()

        super.init(nibName: nil, bundle: nil)
    }

    // swiftlint:disable:next unavailable_function
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChild(self.rootTabBarController)
        self.rootTabBarController.view.frame = self.view.bounds
        self.view.addSubview(self.rootTabBarController.view)
        self.rootTabBarController.didMove(toParent: self)
    }
}
