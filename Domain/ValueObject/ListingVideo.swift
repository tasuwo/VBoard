//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

/**
 * 一覧表示可能な動画情報
 */
public struct ListingVideo {
    /// サムネイル情報
    public struct Thumbnail {
        /// デフォルトのサムネイル画像のURL
        public let `default`: URL
        /// やや解像度の高いサムネイル画像のURL
        public let medium: URL?
        /// 高解像度のサムネイル画像
        public let high: URL?

        public init(default: URL, medium: URL?, high: URL?) {
            self.default = `default`
            self.medium = medium
            self.high = high
        }
    }

    /// ID
    public let videoId: String
    /// タイトル
    public let title: String
    /// チャンネルタイトル
    public let channelTitle: String
    /// 投稿日時
    public let publichedAt: Date
    /// サムネイル
    public let thumbnail: Thumbnail

    // MARK: - Lifecycle

    public init(videoId: String, title: String, channelTitle: String, publishedAt: Date, thumbnail: Thumbnail) {
        self.videoId = videoId
        self.title = title
        self.channelTitle = channelTitle
        self.publichedAt = publishedAt
        self.thumbnail = thumbnail
    }
}
