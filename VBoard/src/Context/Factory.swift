//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

/// @mockable
protocol ViewControllerFactory {
    func makeAppRootTabBarController() -> AppRootTabBarControllerProtocol
    func makeSearchEntryViewController(with entry: String?) -> SearchEntryViewControllerProtocol
    func makeSearchResultViewController(query: String) -> SearchResultViewControllerProtocol
}
