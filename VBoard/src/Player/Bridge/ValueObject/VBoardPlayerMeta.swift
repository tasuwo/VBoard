//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Foundation

struct VBoardPlayerMeta {
    struct Context {
        let volume: Int
        let rate: Double
    }

    let duration: TimeInterval
    let availableRates: [Double]

    let context: Context
}
