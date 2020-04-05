//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import VBoardUIKit

protocol SearchResultViewControllerProtocol: UIViewController {}

class SearchResultViewController: UIViewController, SearchResultViewControllerProtocol {
    // MARK: - Type Aliases

    typealias Factory = ViewControllerFactory

    // MARK: - Properties

    private let factory: Factory
    private let viewModel: SearchResultViewModel
    private let disposeBag = DisposeBag()
    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - IBOutlets

    @IBOutlet var tableView: ContentContainerTableView!

    // MARK: - Initializer

    init(factory: Factory, viewModel: SearchResultViewModel) {
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

        // 初期化
        self.searchController.searchBar.text = self.viewModel.query.value

        self.searchController.searchBar
            .rx.text.bind(to: self.viewModel.query)
            .disposed(by: self.disposeBag)

        self.searchController.searchBar
            .rx.searchButtonClicked.subscribe(onNext: { [weak self] _ in
                self?.pushResultViewController()
            })
            .disposed(by: self.disposeBag)

        self.viewModel.items
            .bind(to: self.tableView.rx.items(cellIdentifier: ContentContainerTableView.reuseIdentifier)) { _, element, cell in
                guard let cell = cell as? ContentContainer else { return }
                cell.title = element.title
                if let thumbnail = element.thumbnail.medium {
                    cell.thumbnailUrl = thumbnail
                } else {
                    cell.thumbnailUrl = element.thumbnail.default
                }
                cell.uploadDate = element.publishedAt
            }
            .disposed(by: self.disposeBag)

        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)

        self.viewModel.doSearch()
    }

    // MARK: - Methods

    func pushResultViewController() {
        if let query = self.viewModel.query.value {
            let viewController = self.factory.makeSearchResultViewController(query: query)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension SearchResultViewController: UITableViewDelegate {
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ContentContainer.preferredHeight
    }
}
