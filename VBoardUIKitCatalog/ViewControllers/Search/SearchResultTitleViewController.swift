//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import VBoardUIKit

class SearchResultTitleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: false)

        self.navigationItem.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)

        let titleView = SearchResultTitleView(frame: .init(origin: .zero,
                                                           size: self.navigationController?.navigationBar.frame.size ?? .zero))
        titleView.title = "Searched Query"
        titleView.delegate = self
        titleView.translatesAutoresizingMaskIntoConstraints = true
        titleView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.navigationItem.titleView = titleView
    }
}

extension SearchResultTitleViewController: SearchResultTitleViewDelegate {
    // MARK: - SearchResultTitleViewDelegate

    func didTapTitle() {
        print(#function)
    }
}
