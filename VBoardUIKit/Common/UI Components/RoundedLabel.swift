//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

@IBDesignable
class RoundedLabel: UILabel {
    // MARK: - Property

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += horizontalPadding * 2
        contentSize.height += verticalPadding * 2
        return contentSize
    }

    // MARK: IBInspectable

    @IBInspectable var horizontalPadding: CGFloat = 0
    @IBInspectable var verticalPadding: CGFloat = 0
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    // MARK: Lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.invalidateIntrinsicContentSize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.invalidateIntrinsicContentSize()
    }
}
