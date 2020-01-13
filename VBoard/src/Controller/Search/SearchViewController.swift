//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit

protocol SearchViewControllerProtocol: UIViewController {}

class SearchViewController: UIViewController, SearchViewControllerProtocol {
    typealias Factory = ViewControllerFactory

    private let factory: Factory

    // MARK: - Initializer

    init(factory: Factory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = NSLocalizedString("SearchView.title", comment: "")
    }
}
