//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import VBoardUIKit

protocol SearchEntryViewControllerProtocol: UIViewController {}

class SearchEntryViewController: UIViewController, SearchEntryViewControllerProtocol {
    // MARK: - Type Aliases

    typealias Factory = ViewControllerFactory
    typealias Dependency = SearchEntryViewModelType

    // MARK: - Properties

    private let factory: Factory
    private let viewModel: SearchEntryViewModelType
    private var titleView: SearchEntryView!

    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    init(factory: Factory, viewModel: SearchEntryViewModelType) {
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

        self.setupNavigationBar()

        self.bind(to: self.viewModel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.title = L10n.SearchView.title
    }

    // MARK: - Methods

    private func setupNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        self.navigationItem.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)

        self.titleView = SearchEntryView(frame: .init(origin: .zero,
                                                      size: self.navigationController?.navigationBar.frame.size ?? .zero))
        self.titleView.searchBar.placeholder = L10n.SearchView.placeholder

        self.titleView.translatesAutoresizingMaskIntoConstraints = true
        self.titleView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.navigationItem.titleView = self.titleView

        self.titleView.focusSearchBar()
    }
}

extension SearchEntryViewController {
    // MARK: - Binding

    func bind(to dependency: Dependency) {
        // MARK: Outputs

        dependency.outputs.entryUpdated
            .drive(self.titleView.searchBar.rx.text)
            .disposed(by: self.disposeBag)

        dependency.outputs.searchResultViewShown
            .emit(onNext: { [weak self] query in
                guard let self = self else { return }
                let viewController = self.factory.makeSearchResultViewController(query: query)
                self.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: self.disposeBag)

        // MARK: Inputs

        // NOTE: For setting initial entry to searchBar, inputs MUST be binded after outputs.
        self.titleView.searchBar.rx
            .text
            .bind(to: dependency.inputs.entry)
            .disposed(by: self.disposeBag)

        self.titleView.searchBar.rx
            .searchButtonClicked
            .bind(to: dependency.inputs.searchButtonClicked)
            .disposed(by: self.disposeBag)
    }
}
