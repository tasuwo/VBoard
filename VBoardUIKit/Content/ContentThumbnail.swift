//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Kingfisher

public class ContentThumbnail: UIView {
    // MARK: - Properties

    public var thumbnailUrl: URL? {
        didSet {
            guard let url = thumbnailUrl else { return }
            self.thumbnailImageView.kf.setImage(with: url)
        }
    }

    public var duration: Int? {
        get {
            guard !self.durationLabel.isHidden, let string = self.durationLabel.text else { return nil }
            return DurationFormatter.integer(from: string)
        }
        set {
            guard let duration = newValue else {
                self.durationLabel.text = nil
                self.durationLabel.isHidden = true
                return
            }
            self.durationLabel.isHidden = false
            self.durationLabel.text = DurationFormatter.string(from: duration)
        }
    }

    // MARK: - IBOutlets

    @IBOutlet private var baseView: UIView!
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var durationLabel: UILabel!

    // MARK: - Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNib()
    }

    // MARK: - Methods

    private func loadNib() {
        guard let bundle = ResourceBundle.bundle else { return }
        bundle.loadNibNamed("ContentThumbnail", owner: self, options: nil)

        self.baseView.frame = self.bounds
        self.addSubview(self.baseView)
    }
}
