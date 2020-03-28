//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

/**
 * 検索のソートに利用するクエリ
 */
public struct SearchQuery {
    /// ソート順
    public enum SortOrder {
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

        /// デフォルト設定
        public static var `default`: Self {
            .relevance
        }
    }

    /// 動画長
    public enum Length {
        /// 動画長に基づいてフィルタしない
        case any
        /// 20分を超える動画のみ
        case long
        /// 4分以上20分未満の動画のみ
        case medium
        /// 4分未満の動画のみ
        case short

        /// デフォルト設定
        public static var `default`: Self {
            .any
        }
    }

    /// 投稿日
    public enum UploadDate {
        /// 指定なし
        case any
        /// 1時間以内
        case hour
        /// 本日
        case today
        /// 今週
        case thisWeek
        /// 今月
        case thisMonth
        /// 今年
        case thisYear

        /// デフォルト設定
        public static var `default`: Self {
            .any
        }

        // MARK: - Methods

        /**
         * その日付以降を指定すればクエリ通りのリクエストとなるような日付を取得する
         *
         * - parameters:
         *   - date: 基準日
         * - returns: 以降の日付
         */
        public func publishedAfter(basedOn date: Date) -> Date? {
            switch self {
            case .any:
                return nil

            case .hour:
                return date.addingTimeInterval(-1 * 60 * 60)

            case .today:
                return Calendar(identifier: .gregorian)
                    .date(from: Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: date))

            case .thisWeek:
                return Calendar(identifier: .gregorian)
                    .date(from: Calendar(identifier: .gregorian).dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))

            case .thisMonth:
                return Calendar(identifier: .gregorian)
                    .date(from: Calendar(identifier: .gregorian).dateComponents([.year, .month], from: date))

            case .thisYear:
                return Calendar(identifier: .gregorian)
                    .date(from: Calendar(identifier: .gregorian).dateComponents([.year], from: date))
            }
        }
    }

    /// デフォルトのページサイズ
    public static let defaultPageSize: UInt = 10

    /// クエリ文字列
    public let query: String
    /// ソート順
    public let sortOrder: SortOrder
    /// 動画長
    public let length: Length
    /// 投稿日
    public let uploadDate: UploadDate
    /// ページトークン
    public let pageToken: String?
    /// ページサイズ
    public let pageSize: UInt

    // MARK: - Lifecycle

    public init(query: String,
                sortOrder: SortOrder = .default,
                length: Length = .default,
                uploadDate: UploadDate = .default,
                pageToken: String? = nil,
                pageSize: UInt = SearchQuery.defaultPageSize) {
        self.query = query
        self.sortOrder = sortOrder
        self.length = length
        self.uploadDate = uploadDate
        self.pageToken = pageToken
        self.pageSize = pageSize
    }
}
