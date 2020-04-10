//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

/**
 * - seeAlso: https://developers.google.com/youtube/iframe_api_reference#Events
 */
enum VBoardPlayerState {
    case unstarted
    case ended
    case playing
    case paused
    case buffering
    case cued

    init?(code: Int) {
        switch code {
        case -1:
            self = .unstarted
        case 0:
            self = .ended
        case 1:
            self = .playing
        case 2:
            self = .paused
        case 3:
            self = .buffering
        case 5:
            self = .cued
        default:
            return nil
        }
    }
}
