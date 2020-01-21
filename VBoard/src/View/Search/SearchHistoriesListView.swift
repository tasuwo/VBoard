//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit

class SearchHistoriesListView: UITableView {
    static let identifier = "SearchHistoriesListView"

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
        self.separatorStyle = .none
        self.rowHeight = 40
    }

    private func loadFromNib() {
        let nib = UINib(nibName: "SearchHistoryCell", bundle: nil)
        register(nib, forCellReuseIdentifier: type(of: self).identifier)
    }
}
