//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol SearchResultViewControllerProtocol: UIViewController {}

class SearchResultViewController: UIViewController, SearchResultViewControllerProtocol {
    typealias Factory = ViewControllerFactory

    private let factory: Factory
    private let viewModel: SearchResultViewModel
    private let disposeBag = DisposeBag()

    @IBOutlet var searchResultsView: SearchResultsListView!
    private var searchController: UISearchController!

    private var thumbnailCache: [IndexPath: UIImage] = [:]
    private var thumbnailDownloadersInProgress: [IndexPath: ThumbnailDowloaderProtocol] = [:]

    // MARK: - Initializer

    init(factory: Factory, viewModel: SearchResultViewModel) {
        self.factory = factory
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchController = UISearchController(searchResultsController: nil)
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
            .bind(to: self.searchResultsView.rx.items(cellIdentifier: SearchResultsListView.identifier)) { [weak self] row, element, cell in
                guard let self = self else { return }
                guard let cell = cell as? SearchResultCell else { return }
                let indexPath = IndexPath(item: row, section: 0)

                cell.title = element.title

                let downloader = ThumbnailDownloader(size: cell.thumbnailSize)
                downloader.startDownload(by: element.thumbnail.medium!) { [weak self] result in
                    guard let self = self else { return }

                    switch result {
                    case let .success(image):
                        self.thumbnailCache[indexPath] = image
                        cell.thumbnail = image
                        self.thumbnailDownloadersInProgress.removeValue(forKey: indexPath)
                    case .failure:
                        break
                    }
                }
                self.thumbnailDownloadersInProgress[indexPath] = downloader
            }
            .disposed(by: self.disposeBag)

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
