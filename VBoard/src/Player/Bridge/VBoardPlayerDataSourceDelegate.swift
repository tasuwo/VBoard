//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Foundation

protocol VBoardPlayerDataSourceDelegate: AnyObject {
    func onReady()

    func onFetched(meta: VBoardPlayerMeta)

    func onStateChanged(to state: VBoardPlayerState)

    func onQualityChanged(to quality: VBoardPlayerQuality)

    func onRateChanged(to rate: Double)

    func onError(_ error: VBoardPlayerPlaybackError)

    func onCurrenTimeChanged(to time: TimeInterval)

    func onBufferChanged(to ratio: Double)
}
