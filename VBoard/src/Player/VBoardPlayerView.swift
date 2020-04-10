//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit
import WebKit

public class VBoardPlayerView: UIView {
    // MARK: - Properties

    public let player: VBoardPlayer

    private let webView: WKWebView
    private let bridge: YouTubeIFrameApiBridge

    // MARK: - IBOutlets

    @IBOutlet var baseView: UIView!

    // MARK: - Lifecycle

    override public init(frame: CGRect) {
        self.bridge = YouTubeIFrameApiBridge()
        self.webView = WKWebView(frame: .zero,
                                 configuration: self.bridge.makeBridgeableWKWebViewConfiguration())
        self.player = VBoardPlayer(handler: self.bridge)

        super.init(frame: frame)

        self.loadNib()
        self.setupDelegates()
    }

    public required init?(coder: NSCoder) {
        self.bridge = YouTubeIFrameApiBridge()
        self.webView = WKWebView(frame: .zero,
                                 configuration: self.bridge.makeBridgeableWKWebViewConfiguration())
        self.player = VBoardPlayer(handler: self.bridge)

        super.init(coder: coder)

        self.loadNib()
        self.setupDelegates()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()

        self.webView.frame = self.baseView.frame
        self.baseView.addSubview(self.webView)
    }

    // MARK: - Methods

    private func setupDelegates() {
        self.bridge.dataSourceDelegate = self.player
        self.bridge.delegate = self
    }

    private func loadNib() {
        Bundle.main.loadNibNamed("VBoardPlayerView", owner: self, options: nil)

        self.baseView.frame = self.bounds
        self.addSubview(self.baseView)
    }
}

extension VBoardPlayerView: YouTubeIFrameApiBridgeDelegate {
    // MARK: - YouTubeIFrameApiForwardingBridgeDelegate

    func load(html: String) {
        self.webView.loadHTMLString(html, baseURL: nil)
    }

    func evaluateJavaScript(_ script: String) {
        self.webView.evaluateJavaScript(script, completionHandler: nil)
    }
}
