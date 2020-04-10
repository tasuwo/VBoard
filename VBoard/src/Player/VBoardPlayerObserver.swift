//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

public protocol VBoardPlayerObserver: AnyObject {
    func onUnstarted()

    func onReady()

    func onEnded()

    func onPlaying()

    func onPaused()

    func onBuffering()

    func onCued()

    func onError(_ error: VBoardPlayerPlaybackError)

    func onQualityChanged(to quality: VBoardPlayerQuality)

    func onRateChanged(to rate: Double)

    func onCurrentTimeUpdated(to time: Double)

    func onBufferUpdated(to ratio: Double)
}
