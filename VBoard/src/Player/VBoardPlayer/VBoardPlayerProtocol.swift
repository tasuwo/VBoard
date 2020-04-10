//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Foundation

public protocol VBoardPlayerProtocol {
    ///  The YouTube video ID that identifies the video
    var videoId: String? { get }

    ///  The duration in seconds
    var duration: TimeInterval? { get }

    /// The elapsed time in seconds since the video started playing
    var currentTime: TimeInterval? { get }

    /// A number between 0 and 1 that specifies the percentage of the video that the player shows as buffered
    var bufferingRatio: Double? { get }

    /// The player's current volume. Accepts an integer between 0 and 100
    var volume: Int? { get }

    /// The playback rate of the currently playing video
    var rate: Double? { get }

    /// The set of playback rates in which the current video is available
    var availableRates: [Double]? { get }

    /// The playback quality of the currently playing video
    var quality: VBoardPlayerQuality? { get }

    var isPlaying: Bool { get }

    var isStalling: Bool { get }

    func load(_ videoId: String)

    func play()

    func pause()

    func seek(to: TimeInterval)

    func setRate(to: Double)

    func setVolume(to: Int)
}
