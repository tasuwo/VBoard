//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

/// @mockable
protocol ViewControllerFactory {
    func makeAppRootTabBarController() -> AppRootTabBarControllerProtocol
    func makeSearchViewController() -> SearchViewControllerProtocol
    func makeSearchResultViewController(query: String) -> SearchResultViewControllerProtocol
}
