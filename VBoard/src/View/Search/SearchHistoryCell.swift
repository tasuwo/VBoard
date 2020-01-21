//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit

class SearchHistoryCell: UITableViewCell {
    public var title: String? {
        set {
            self.titleLabel.text = newValue
        }
        get {
            return self.titleLabel.text
        }
    }

    // MARK: - IBOutlet

    @IBOutlet var titleLabel: UILabel!
}
