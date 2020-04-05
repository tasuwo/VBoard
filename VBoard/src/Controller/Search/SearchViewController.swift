//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol SearchViewControllerProtocol: UIViewController {}

class SearchViewController: UIViewController, SearchViewControllerProtocol {
    typealias Factory = ViewControllerFactory

    private let factory: Factory
    private let viewModel: SearchViewModel
    private let searchController = UISearchController(searchResultsController: nil)
    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    init(factory: Factory, viewModel: SearchViewModel) {
        self.factory = factory
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // swiftlint:disable:next unavailable_function
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = self.searchController

        self.searchController.searchBar
            .rx.text.bind(to: self.viewModel.query)
            .disposed(by: self.disposeBag)

        self.searchController.searchBar
            .rx.searchButtonClicked.subscribe(onNext: { [weak self] _ in
                self?.pushResultViewController()
            })
            .disposed(by: self.disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = NSLocalizedString("SearchView.title", comment: "")
    }

    // MARK: - Methods

    func pushResultViewController() {
        if let query = self.viewModel.query.value {
            let viewController = self.factory.makeSearchResultViewController(query: query)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
