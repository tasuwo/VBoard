//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit

@IBDesignable
public class ContentContainer: UITableViewCell {
    // MARK: - Property

    public static let preferredHeight: CGFloat = 120

    public static var nib: UINib? {
        guard let bundle = ResourceBundle.bundle else { return nil }
        return UINib(nibName: "ContentContainer", bundle: bundle)
    }

    public var thumbnailUrl: URL? {
        get {
            self.thumbnail.thumbnailUrl
        }
        set {
            self.thumbnail.thumbnailUrl = newValue
        }
    }

    public var duration: Int? {
        get {
            self.thumbnail.duration
        }
        set {
            self.thumbnail.duration = newValue
        }
    }

    public var uploadDate: Date? {
        get {
            guard let string = self.uploadDateLabel.text else { return nil }
            return UploadDateFormatter.date(from: string)
        }
        set {
            guard let date = newValue else {
                self.uploadDateLabel.text = nil
                return
            }
            self.uploadDateLabel.text = UploadDateFormatter.string(from: date)
        }
    }

    public var title: String? {
        get {
            self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }

    // MARK: - IBOutlets

    @IBOutlet private var thumbnail: ContentThumbnail!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var uploadDateLabel: UILabel!

    // MARK: - Lifecycle

    override public func awakeFromNib() {
        super.awakeFromNib()

        self.applyInitialValues()
    }

    // MARK: - Methods

    private func applyInitialValues() {
        self.thumbnailUrl = nil
        self.duration = nil
        self.uploadDate = nil
        self.title = nil
    }
}
