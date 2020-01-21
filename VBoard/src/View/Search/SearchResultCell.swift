//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    public var title: String? {
        set {
            self.titleLabel.text = newValue
        }
        get {
            return self.titleLabel.text
        }
    }

    public var thumbnail: UIImage? {
        set {
            if let image = newValue {
                self.thumbnailView.image = image
            } else {
                self.thumbnailView.image = self.emptyThumbnail(by: .gray, size: self.thumbnailSize)
            }
        }
        get {
            return self.thumbnailView.image
        }
    }

    public var thumbnailSize: CGSize {
        return self.thumbnailView.frame.size
    }

    // MARK: - IBOutlet

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbnailView: UIImageView!

    // MARK: - Methods

    private func emptyThumbnail(by color: UIColor, size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { ctx in
            let rect = CGRect(origin: .zero, size: size)
            ctx.cgContext.addRect(rect)
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.drawPath(using: .fill)
        }
        return image
    }
}
