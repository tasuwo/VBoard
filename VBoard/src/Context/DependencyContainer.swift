//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

class DependencyContainer {}

extension DependencyContainer: ViewControllerFactory {
    // MARK: - ViewControllerFactory

    func makeAppRootTabBarController() -> AppRootTabBarControllerProtocol {
        return AppRootTabBarController(factory: self)
    }

    func makeSearchViewController() -> SearchViewControllerProtocol {
        return SearchViewController(factory: self)
    }
}
