//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit

public class ContentContainerTableView: UITableView {
    public static let reuseIdentifier: String = "ContentContainer"

    // MARK: - Lifecycle

    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.registerNib()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.registerNib()
    }

    // MARK: - Methods

    private func registerNib() {
        self.register(ContentContainer.nib, forCellReuseIdentifier: Self.reuseIdentifier)
    }
}
