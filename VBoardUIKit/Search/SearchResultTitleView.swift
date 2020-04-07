//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit

public protocol SearchResultTitleViewDelegate: AnyObject {
    func didTapTitle()
}

public class SearchResultTitleView: UIView {
    // MARK: - Properties

    public weak var delegate: SearchResultTitleViewDelegate?

    public var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }

    // MARK: - IBOutlets

    @IBOutlet private var baseView: UIView!
    @IBOutlet private var titleLabel: UILabel!

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

    @IBAction func didTapTitle(_ sender: Any) {
        self.delegate?.didTapTitle()
    }

    // MARK: - Methods

    private func loadNib() {
        guard let bundle = ResourceBundle.bundle else { return }
        bundle.loadNibNamed("SearchResultTitleView", owner: self, options: nil)

        self.baseView.frame = self.bounds
        self.addSubview(self.baseView)
    }
}
