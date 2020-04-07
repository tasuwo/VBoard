//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import VBoardUIKit

class SearchEntryViewController: UIViewController {
    private var titleView: SearchEntryView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: false)

        self.navigationItem.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)

        self.titleView = SearchEntryView(frame: .init(origin: .zero,
                                                     size: self.navigationController?.navigationBar.frame.size ?? .zero))
        self.titleView.searchBar.delegate = self
        self.titleView.searchBar.text = "Searched Query"
        self.titleView.searchBar.placeholder = "Search"

        self.titleView.translatesAutoresizingMaskIntoConstraints = true
        self.titleView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.navigationItem.titleView = self.titleView

        self.titleView.focusSearchBar()
    }
}

extension SearchEntryViewController: UISearchBarDelegate {
    // MARK: - UISearchBarDelegate

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.titleView.searchBar.endEditing(true)
        print(#function)
    }
}

