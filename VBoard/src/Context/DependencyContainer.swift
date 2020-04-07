//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Infrastructure

class DependencyContainer {}

extension DependencyContainer: ViewControllerFactory {
    // MARK: - ViewControllerFactory

    func makeAppRootTabBarController() -> AppRootTabBarControllerProtocol {
        AppRootTabBarController(factory: self)
    }

    func makeSearchEntryViewController(with entry: String?) -> SearchEntryViewControllerProtocol {
        let viewModel = SearchEntryViewModel(initialEntry: entry)
        return SearchEntryViewController(factory: self, viewModel: viewModel)
    }

    func makeSearchResultViewController(query: String) -> SearchResultViewControllerProtocol {
        let viewModel = SearchResultViewModel(service: SearchService(), query: query)
        return SearchResultViewController(factory: self, viewModel: viewModel)
    }
}
