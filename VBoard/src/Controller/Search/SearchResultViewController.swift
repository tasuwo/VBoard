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
    typealias Dependency = SearchResultViewModelType

    // MARK: - Properties

    private let factory: Factory
    private let viewModel: SearchResultViewModelType
    private let disposeBag = DisposeBag()

    // MARK: - IBOutlets

    @IBOutlet var tableView: ContentContainerTableView!

    // MARK: - Initializer

    init(factory: Factory, viewModel: SearchResultViewModelType) {
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

        self.bind(to: self.viewModel)

        self.viewModel.inputs.loaded.accept(())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setupNavigationBar()
    }

    // MARK: - Private Methods

    private func setupNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        self.navigationItem.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)

        let titleView = SearchResultTitleView(frame: .init(origin: .zero,
                                                           size: self.navigationController?.navigationBar.frame.size ?? .zero))
        titleView.title = self.viewModel.outputs.searchedQuery
        titleView.delegate = self
        titleView.translatesAutoresizingMaskIntoConstraints = true
        titleView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.navigationItem.titleView = titleView
    }
}

extension SearchResultViewController {
    // MARK: - Binding

    func bind(to dependency: Dependency) {
        dependency.outputs.items
            .drive(self.tableView.rx.items(cellIdentifier: ContentContainerTableView.reuseIdentifier)) { _, element, cell in
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
    }
}

extension SearchResultViewController: UITableViewDelegate {
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ContentContainer.preferredHeight
    }
}

extension SearchResultViewController: SearchResultTitleViewDelegate {
    // MARK: - SearchResultTitleViewDelegate

    func didTapTitle() {
        print(#function)
    }
}
