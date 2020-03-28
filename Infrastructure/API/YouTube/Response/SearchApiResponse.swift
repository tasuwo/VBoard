//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

extension YouTube {
    /**
     * 検索APIのレスポンスモデル
     *
     * See: https://developers.google.com/youtube/v3/docs/search/list?hl=ja
     */
    public struct SearchApiResponse: Decodable {
        /// 結果セットのページング情報
        public struct PageInfo: Decodable {
            /// 結果の総数
            public let totalResults: Int
            /// APIレスポンスに含まれる結果の数
            public let resultsPerPage: Int
        }

        /// APIリソースのタイプ. 値は youtube#searchListResponse 固定.
        public let kind: String
        /// このリソースのEtag
        public let etag: String
        /// 次のページの取得のために, pageToken パラメータの値として使用できるトークン
        public let nextPageToken: String?
        /// 前のページの取得のために, pageToken パラメータの値として使用できるトークン
        public let prevPageToken: String?
        /// ページング情報
        public let pageInfo: PageInfo
        /// 結果リスト
        public let items: [SearchedItem]
    }
}
