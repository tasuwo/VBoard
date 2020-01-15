//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

extension YouTube {
    /**
     * See: https://developers.google.com/youtube/v3/docs/search?hl=ja#resource
     */
    public struct SearchedItem: Decodable {
        public struct Id: Decodable {
            /// リソースのタイプ
            public let kind: String
            /// リソースのタイプが動画の場合にそのIDが入る
            public let videoId: String?
            /// リソースのタイプがチャンネルの場合にそのIDが入る
            public let channelId: String?
            /// リソースのタイプがプレイリストの場合にそのIDが入る
            public let playlistId: String?
        }

        public struct Snippet: Decodable {
            /// サムネイル画像のマップ
            public struct Thumbnails: Decodable {
                /// デフォルトのサムネイル画像
                public let `default`: Thumbnail
                /// やや解像度の高いサムネイル画像
                public let medium: Thumbnail
                /// 高解像度のサムネイル画像
                public let high: Thumbnail

                enum CodingKeys: String, CodingKey {
                    case `default` = "default"
                    case medium = "medium"
                    case high = "high"
                }
            }

            /// サムネイル画像
            public struct Thumbnail: Decodable {
                /// 画像のURL
                public let url: String
                /// 画像の幅
                public let width: UInt
                /// 画像の高さ
                public let height: UInt
            }

            /// リソースの作成日時
            public let publishedAt: Date
            /// リソースを発行したチャンネルのID
            public let channelId: String
            /// タイトル
            public let title: String
            /// 説明文
            public let description: String
            /// サムネイル
            public let thumbnails: Thumbnails
            /// リソースを発行したチャンネルのタイトル
            public let channelTitle: String
        }

        /// APIリソースのタイプ. 値は youtube#searchResult 固定.
        public let kind: String
        /// このリソースのEtag
        public let etag: String
        /// リソースを一意に特定できる情報
        public let id: Id?
        /// 基本情報
        public let snippet: Snippet?
    }
}
