//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Foundation

public class VBoardPlayer {
    // MARK: - Properties

    public var observers: [VBoardPlayerObserver] = []

    private let queue = DispatchQueue(label: "net.tasuwo.VBoard.VBoardPlayer")
    private let handler: VBoardPlayerCommandHandler

    private var internalVideoId: String?
    private var internalQuality: VBoardPlayerQuality?
    private var internalBufferRatio: Double? = 0
    private var internalCurrentTime: Double? = 0
    private var internalVolume: Int? = 0
    private var internalRate: Double? = 0

    private var meta: VBoardPlayerMeta?
    private var state: VBoardPlayerState = .unstarted

    // MARK: - Lifecycle

    init(handler: VBoardPlayerCommandHandler) {
        self.handler = handler
    }
}

extension VBoardPlayer: VBoardPlayerProtocol {
    // MARK: - VBoardPlayerProtocol

    public var videoId: String? {
        return self.internalVideoId
    }

    public var duration: TimeInterval? {
        return self.meta?.duration
    }

    public var currentTime: TimeInterval? {
        return self.internalCurrentTime
    }

    public var bufferingRatio: Double? {
        return self.internalBufferRatio
    }

    public var volume: Int? {
        return self.internalVolume
    }

    public var rate: Double? {
        return self.internalRate
    }

    public var availableRates: [Double]? {
        return self.meta?.availableRates
    }

    public var quality: VBoardPlayerQuality? {
        return self.internalQuality
    }

    public var isPlaying: Bool {
        return self.state == .playing
    }

    public var isStalling: Bool {
        return self.state == .buffering
    }

    public func load(_ videoId: String) {
        self.internalVideoId = videoId

        self.internalQuality = nil
        self.internalBufferRatio = nil
        self.internalCurrentTime = nil
        self.internalVolume = nil
        self.internalRate = nil
        self.meta = nil
        self.state = .unstarted

        self.handler.execute(.load(videoId: videoId))
    }

    public func play() {
        self.handler.execute(.play)
    }

    public func pause() {
        self.handler.execute(.pause)
    }

    public func seek(to time: TimeInterval) {
        self.handler.execute(.seek(to: time))
    }

    public func setRate(to rate: Double) {
        self.handler.execute(.rate(to: rate))
    }

    public func setVolume(to volume: Int) {
        self.handler.execute(.volume(to: volume))
    }
}

extension VBoardPlayer: VBoardPlayerDataSourceDelegate {
    func onReady() {
        self.queue.async { [weak self] in
            self?.observers.forEach { $0.onReady() }
        }
    }

    func onFetched(meta: VBoardPlayerMeta) {
        self.meta = meta
    }

    func onStateChanged(to state: VBoardPlayerState) {
        self.state = state

        switch state {
        case .unstarted:
            self.queue.async { [weak self] in
                self?.observers.forEach { $0.onUnstarted() }
            }
        case .playing:
            self.queue.async { [weak self] in
                self?.observers.forEach { $0.onPlaying() }
            }
        case .paused:
            self.queue.async { [weak self] in
                self?.observers.forEach { $0.onPaused() }
            }
        case .ended:
            self.queue.async { [weak self] in
                self?.observers.forEach { $0.onEnded() }
            }
        case .buffering:
            self.queue.async { [weak self] in
                self?.observers.forEach { $0.onBuffering() }
            }
        case .cued:
            self.queue.async { [weak self] in
                self?.observers.forEach { $0.onCued() }
            }
        }
    }

    func onQualityChanged(to quality: VBoardPlayerQuality) {
        self.internalQuality = quality

        self.queue.async { [weak self] in
            self?.observers.forEach { $0.onQualityChanged(to: quality) }
        }
    }

    func onRateChanged(to rate: Double) {
        self.internalRate = rate

        self.queue.async { [weak self] in
            self?.observers.forEach { $0.onRateChanged(to: rate) }
        }
    }

    func onError(_ error: VBoardPlayerPlaybackError) {
        self.queue.async { [weak self] in
            self?.observers.forEach { $0.onError(error) }
        }
    }

    func onCurrenTimeChanged(to time: TimeInterval) {
        self.internalCurrentTime = time

        self.queue.async { [weak self] in
            self?.observers.forEach { $0.onCurrentTimeUpdated(to: time) }
        }
    }

    func onBufferChanged(to ratio: Double) {
        self.internalBufferRatio = ratio

        self.queue.async { [weak self] in
            self?.observers.forEach { $0.onBufferUpdated(to: ratio) }
        }
    }
}
