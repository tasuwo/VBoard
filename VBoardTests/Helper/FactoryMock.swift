//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit
@testable import VBoard

class AppRootTabBarControllerMock: UITabBarController, AppRootTabBarControllerProtocol {}
class SearchViewControllerMock: UITabBarController, SearchViewControllerProtocol {}

class FactoryMock: ViewControllerFactory {
    var rootTabBarController: AppRootTabBarControllerProtocol = AppRootTabBarControllerMock()
    var searchViewController: SearchViewControllerProtocol = SearchViewControllerMock()

    // MARK: - ViewControllerFactory

    func makeAppRootTabBarController() -> AppRootTabBarControllerProtocol {
        return self.rootTabBarController
    }

    func makeSearchViewController() -> SearchViewControllerProtocol {
        return self.searchViewController
    }
}
