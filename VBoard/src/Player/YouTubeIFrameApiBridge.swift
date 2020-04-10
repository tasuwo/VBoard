//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Foundation
import WebKit

protocol YouTubeIFrameApiBridgeDelegate: AnyObject {
    func load(html: String)

    func evaluateJavaScript(_ script: String)
}

class YouTubeIFrameApiBridge: NSObject {
    /**
     * - seeAlso: https://developers.google.com/youtube/iframe_api_reference#Events
     */
    enum Event: String, CaseIterable {
        case ready
        case metaFetched
        case stateChanged
        case qualityChanged
        case rateChanged
        case error
        case playbackTimeUpdated
        case bufferUpdated
    }

    // MARK: - Properties

    weak var delegate: YouTubeIFrameApiBridgeDelegate?
    weak var dataSourceDelegate: VBoardPlayerDataSourceDelegate?

    // MARK: - Methods

    func makeBridgeableWKWebViewConfiguration() -> WKWebViewConfiguration {
        let contentController = WKUserContentController()
        Event.allCases.forEach { event in
            contentController.add(self, name: event.rawValue)
        }

        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.allowsPictureInPictureMediaPlayback = false
        config.userContentController = contentController

        return config
    }

    // MARK: - Private Methods

    private static func makeBridgeablePlayerHtmlString(by videoId: String) -> String {
        let path = Bundle.main.path(forResource: "Player", ofType: "html")!

        guard let baseHtmlString = try? String(contentsOfFile: path, encoding: .utf8) else {
            fatalError("Resouce Player.html not found.")
        }

        return String(format: baseHtmlString, videoId)
    }
}

extension YouTubeIFrameApiBridge: VBoardPlayerCommandHandler {
    // MARK: - VBoardPlayerCommandHandler

    func execute(_ command: VBoardPlayerCommand) {
        if case let .load(videoId: id) = command {
            self.delegate?.load(html: Self.makeBridgeablePlayerHtmlString(by: id))
        } else {
            self.delegate?.evaluateJavaScript(command.javascriptCommand)
        }
    }
}

extension YouTubeIFrameApiBridge: WKScriptMessageHandler {
    // MARK: - WKScriptMessageHandler

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let event = Event(rawValue: message.name) else { return }

        switch event {
        case .ready:
            self.dataSourceDelegate?.onReady()

        case .metaFetched:
            guard let dic = message.body as? [String: AnyObject],
                let volume = dic["volume"] as? Int,
                let rate = dic["rate"] as? Double,
                let duration = dic["duration"] as? TimeInterval,
                let availableRates = dic["availableRates"] as? [Double] else { return }
            let meta = VBoardPlayerMeta(duration: duration,
                                        availableRates: availableRates,
                                        context: VBoardPlayerMeta.Context(volume: volume, rate: rate))
            self.dataSourceDelegate?.onFetched(meta: meta)

        case .stateChanged:
            guard let code = message.body as? Int,
                let state = VBoardPlayerState(code: code) else { return }
            self.dataSourceDelegate?.onStateChanged(to: state)

        case .qualityChanged:
            guard let code = message.body as? String,
                let quality = VBoardPlayerQuality(rawValue: code) else { return }
            self.dataSourceDelegate?.onQualityChanged(to: quality)

        case .rateChanged:
            guard let rate = message.body as? Double else { return }
            self.dataSourceDelegate?.onRateChanged(to: rate)

        case .error:
            guard let code = message.body as? Int,
                let error = VBoardPlayerPlaybackError(code: code) else { return }
            self.dataSourceDelegate?.onError(error)

        case .playbackTimeUpdated:
            guard let time = message.body as? Double else { return }
            self.dataSourceDelegate?.onCurrenTimeChanged(to: time)

        case .bufferUpdated:
            guard let ratio = message.body as? Double else { return }
            self.dataSourceDelegate?.onBufferChanged(to: ratio)
        }
    }
}

private extension VBoardPlayerCommand {
    var javascriptCommand: String {
        switch self {
        case let .load(videoId: id):
            return "player.cueVideoById(\(id), 0)"
        case .play:
            return "player.playVideo();"
        case .pause:
            return "player.pauseVideo();"
        case let .seek(to: time):
            return "player.seekTo(\(time), true);"
        case let .volume(to: volume):
            return "player.setVolume(\(volume));"
        case let .rate(to: rate):
            return "player.setPlaybackRate(\(rate));"
        }
    }
}

private extension VBoardPlayerPlaybackError {
    init?(code: Int) {
        switch code {
        case 2:
            self = .internalError
        case 5:
            self = .internalError
        case 100:
            self = .notFound
        case 101, 150:
            self = .forbidden
        default:
            return nil
        }
    }
}
