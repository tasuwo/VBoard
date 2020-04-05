//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

// swiftlint:disable:next convenience_type
class ResourceBundle {
    private static let resourceBundleName = "VBoardUIKit"

    static let bundle: Bundle? = {
        guard let path = Bundle(for: ResourceBundle.self).path(forResource: ResourceBundle.resourceBundleName, ofType: "bundle") else {
            return nil
        }
        return Bundle(path: path)
    }()
}
