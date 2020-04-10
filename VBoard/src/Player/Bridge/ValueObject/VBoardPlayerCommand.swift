//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Foundation

enum VBoardPlayerCommand {
    case load(videoId: String)
    case play
    case pause
    case seek(to: TimeInterval)
    case volume(to: Int)
    case rate(to: Double)
}
