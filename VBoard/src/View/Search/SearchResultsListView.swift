//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit

class SearchResultsListView: UITableView {
    static let identifier = "SearchResultsListView"

    // MARK: - Lifecycle

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.applyAppearance()
        self.loadFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.applyAppearance()
        self.loadFromNib()
    }

    // MARK: - Methods

    private func applyAppearance() {
        self.separatorInset = .zero
        self.rowHeight = 120
    }

    private func loadFromNib() {
        let nib = UINib(nibName: "SearchResultCell", bundle: nil)
        register(nib, forCellReuseIdentifier: type(of: self).identifier)
    }
}
