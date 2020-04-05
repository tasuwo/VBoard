//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

// sourcery: AutoDefaultValue
/**
 * データの一覧取得時のページングに関する情報
 */
public struct PageInfo {
    /// 結果の総数
    public let totalResults: Int
    /// 今回の取得数
    public let resultsPerPage: Int
    /// 前のページ取得のために利用するトークン
    public let prevPageToken: String?
    /// 次のページ取得のために利用するトークン
    public let nextPageToken: String?

    // MARK: - Lifecycle

    public init(totalResults: Int, resultsPerPage: Int, prevPageToken: String?, nextPageToken: String?) {
        self.totalResults = totalResults
        self.resultsPerPage = resultsPerPage
        self.prevPageToken = prevPageToken
        self.nextPageToken = nextPageToken
    }
}
