//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Foundation

struct APIHelper {
    static func composeQueryParameters(_ source: [String?: Any?]) -> [String: Any] {
        return source.reduce(into: [String: Any]()) { prev, pair in
            guard let key = pair.key, let value = pair.value else { return }
            prev[key] = value
        }
    }
}
