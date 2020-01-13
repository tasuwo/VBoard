//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

protocol ViewControllerFactory {
    func makeAppRootTabBarController() -> AppRootTabBarControllerProtocol
    func makeSearchViewController() -> SearchViewControllerProtocol
}
