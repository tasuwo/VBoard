//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import APIKit
import Foundation

extension YouTube {
    /**
     * Search:list
     *
     * See: https://developers.google.com/youtube/v3/docs/search/list?hl=ja&apix_params=%7B%22part%22%3A%22id%2Csnippet%22%7D
     */
    public struct SearchRequest: YouTubeV3BaseRequest {
        public typealias Response = SearchApiResponse

        public enum Part: String {
            case id
            case snippet
        }

        public enum Filter {
            case forCounterOwner(Bool)
            case forMine(Bool)
            case relatedToVideoId(String)

            public var key: String {
                switch self {
                case .forCounterOwner(_):
                    return "forCounterOwner"
                case .forMine(_):
                    return "forMine"
                case .relatedToVideoId(_):
                    return "relatedToVideoId"
                }
            }

            public var value: String {
                switch self {
                case let .forCounterOwner(value):
                    return String(value)
                case let .forMine(value):
                    return String(value)
                case let .relatedToVideoId(value):
                    return value
                }
            }
        }

        public enum ChannelType {
            /// 全てのチャンネル
            case any
            /// 番組のみ
            case show
        }

        public enum EventType {
            /// 完了したブロードキャスト
            case completed
            /// アクティブなブロードキャスト
            case live
            /// 今後配信予定のブロードキャスト
            case upcoming
        }

        public enum Order: String {
            /// 作成日の新しい順
            case date
            /// 評価の高い順
            case rating
            /// 関連性が高い順
            case relevance
            /// タイトルのアルファベット順
            case title
            /// アップロード動画の番号順(降順)
            case videoCount
            /// 再生回数の多い順
            case viewCount
        }

        public enum SafeSearch: String {
            /// 一定のフィルタリングを行う
            /// 少なくともアプリケーションの言語/地域で制限されているコンテンツは除外する
            case moderate
            /// フィルタリングなし
            case none
            /// 制限コンテンツを全て除外
            case strict
        }

        public enum ResourceType: String {
            /// チャンネル
            case channel
            /// プレイリスト
            case playlist
            /// 動画
            case video
        }

        /// 字幕によるフィルタ条件
        public enum VideoCaption: String {
            /// 字幕の有無に基づいてフィルタしない
            case any
            /// 字幕がある動画のみを含む
            case closedCaption
            /// 字幕がない動画のみを含む
            case none
        }

        /// 解像度によるフィルタ条件
        public enum VideoDefinition: String {
            /// 解像度に基づいてフィルタリングしない
            case any
            /// HD動画のみを取得する
            case high
            /// SD動画のみを取得する
            case standard
        }

        public enum VideoDimension: String {
            /// 3D動画を除外する
            case twoD = "2D"
            /// 3D動画に限定する
            case threeD = "3D"
            /// 2D/3D動画に基づいてフィルタリングしない
            case any = "any"
        }

        public enum VideoDuration: String {
            /// 動画長に基づいてフィルタしない
            case any
            /// 20分を超える動画のみ
            case long
            /// 4分以上20分未満の動画のみ
            case medium
            /// 4分未満の動画のみ
            case short
        }

        public enum VideoEmbeddable: String {
            /// 埋め込み可能かどうかにかかわらず取得
            case any
            /// 埋め込み動画のみを取得
            case `true` = "true"
        }

        public enum VideoLicense: String {
            /// ライセンスの種類でフィルタしない
            case any
            /// クリエイティブ・コモンズ ライセンスを持つ動画のみ
            case creativeCommon
            /// 標準のYouTubeライセンスを持つ動画のみ
            case youtube
        }

        public enum VideoSyndicated: String {
            /// シンジケートされているかどうかにかかわらず取得
            case any
            /// シンジケートされている動画のみを取得
            case `true` = "true"
        }

        public enum VideoType: String {
            /// 全ての動画を返す
            case any
            /// 番組のエピソードのみを取得
            case episode
            /// 動画のみを取得
            case movie
        }

        /// レスポンスに含めるリソース
        public let parts: Set<Part>
        /// フィルタ
        public let filter: Filter?
        /// チャンネルID
        public let channelId: String?
        /// 特定のタイプのチャンネル
        public let channelType: ChannelType?
        /// イベントタイプ
        let eventType: EventType?
        /// 結果セットとして返されるアイテムの最大数
        public let maxResults: UInt?
        public let onBehalfOfContentOwner: String?
        /// レスポンス内のリソースのソート順序
        public let order: Order?
        /// 返される結果セットに含める特定のページ
        public let pageToken: String?
        /// 指定日時より後に作成されたリソースのみ含む
        public let publishedAfter: Date?
        /// 指定日時より前に作成されたリソースのみ含む
        public let publishedBefore: Date?
        /// 検索クエリ
        public let q: String?
        /// 国のフィルタ
        public let regionCode: Country?
        /// 制限コンテンツのフィルタ
        public let safeSearch: SafeSearch?
        /// 指定したトピックに関連するリソースのみをAPIレスポンスに含める
        public let topicId: String?
        /// 特定タイプのリソースに制限するフィルタ
        public let type: ResourceType?
        /// 字幕の有無に基づくフィルタ
        public let videoCaption: VideoCaption?
        /// カテゴリに基づくフィルタ
        public let videoCategoryId: String?
        /// 動画の解像度によるフィルタ
        public let videoDefinition: VideoDefinition?
        /// 動画の2D/3Dによるフィルタ
        public let videoDimention: VideoDimension?
        /// 動画長によるフィルタ
        public let videoDuration: VideoDuration?
        /// Webページに埋め込み可能かどうかによるフィルタ
        public let videoEmbeddable: VideoEmbeddable?
        /// 動画のライセンスによるフィルタ
        public let videoLicense: VideoLicense?
        /// youtube.com 以外で再生できる動画に制限するフィルタ
        public let videoSyndicated: VideoSyndicated?
        /// 特定のタイプの動画に制限するフィルタ
        public let videoType: VideoType?

        // MARK: - Lifecycle

        public init(
            parts: Set<Part>,
            filter: Filter? = nil,
            channelId: String? = nil,
            channelType: ChannelType? = nil,
            eventType: EventType? = nil,
            maxResults: UInt? = nil,
            onBehalfOfContentOwner: String? = nil,
            order: Order? = nil,
            pageToken: String? = nil,
            publishedAfter: Date? = nil,
            publishedBefore: Date? = nil,
            q: String? = nil,
            regionCode: Country? = nil,
            safeSearch: SafeSearch? = nil,
            topicId: String? = nil,
            type: ResourceType? = nil,
            videoCaption: VideoCaption? = nil,
            videoCategoryId: String? = nil,
            videoDefinition: VideoDefinition? = nil,
            videoDimention: VideoDimension? = nil,
            videoDuration: VideoDuration? = nil,
            videoEmbeddable: VideoEmbeddable? = nil,
            videoLicense: VideoLicense? = nil,
            videoSyndicated: VideoSyndicated? = nil,
            videoType: VideoType? = nil
        ) {
            self.parts = parts
            self.filter = filter
            self.channelId = channelId
            self.channelType = channelType
            self.eventType = eventType
            self.maxResults = maxResults
            self.onBehalfOfContentOwner = onBehalfOfContentOwner
            self.order = order
            self.pageToken = pageToken
            self.publishedAfter = publishedAfter
            self.publishedBefore = publishedBefore
            self.q = q
            self.regionCode = regionCode
            self.safeSearch = safeSearch
            self.topicId = topicId
            self.type = type
            self.videoCaption = videoCaption
            self.videoCategoryId = videoCategoryId
            self.videoDefinition = videoDefinition
            self.videoDimention = videoDimention
            self.videoDuration = videoDuration
            self.videoEmbeddable = videoEmbeddable
            self.videoLicense = videoLicense
            self.videoSyndicated = videoSyndicated
            self.videoType = videoType
        }

        // MARK: - Request

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/search"
        }

        public var parameters: Any? {
            return APIHelper.composeQueryParameters([
                "part": self.parts.map { $0.rawValue }.joined(separator: ","),
                self.filter?.key: self.filter?.value,
                "channelId": self.channelId,
                "channelType": self.channelType,
                "eventType": self.eventType,
                "maxResults": self.maxResults,
                "order": self.order,
                "pageToken": self.pageToken,
                "publishedAfter": self.publishedAfter,
                "publishedBefore": self.publishedBefore,
                "q": self.q,
                "regionCode": self.regionCode?.alpha2Code,
                "safeSearch": self.safeSearch,
                "topicId": self.topicId,
                "type": self.type,
                "videoCaption": self.videoCaption,
                "videoCategoryId": self.videoCategoryId,
                "videoDefinition": self.videoDefinition,
                "videoDimention": self.videoDimention,
                "videoDuration": self.videoDuration,
                "videoEmbeddable": self.videoEmbeddable,
                "videoLicense": self.videoLicense,
                "videoSyndicated": self.videoSyndicated,
                "videoType": self.videoType,
            ]).merging(self.baseParameters) { _, new in new }
        }

        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
            return try self.defaultDecoder.decode(SearchApiResponse.self, from: object as! Data)
        }
    }
}
