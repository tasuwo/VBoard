//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Foundation

enum APIHelper {
    static func composeQueryParameters(_ source: [String?: Any?]) -> [String: Any] {
        source.reduce(into: [String: Any]()) { prev, pair in
            guard let key = pair.key, let value = pair.value else { return }
            prev[key] = value
        }
    }
}
