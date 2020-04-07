//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit

public class SearchEntryView: UIView {
    // MARK: - IBOutlets

    @IBOutlet private var baseView: UIView!
    @IBOutlet public var searchBar: UISearchBar!

    // MARK: - Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNib()
    }

    // MARK: - IBActions

    // MARK: - Methods

    public func focusSearchBar() {
        self.searchBar.becomeFirstResponder()
    }

    private func loadNib() {
        guard let bundle = ResourceBundle.bundle else { return }
        bundle.loadNibNamed("SearchEntryView", owner: self, options: nil)

        self.baseView.frame = self.bounds
        self.addSubview(self.baseView)
    }
}
