//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import RxRelay
import RxSwift

public enum SearchServiceQuery {
    /// 未ロード
    case notLoaded
    /// ロード中
    case progress
    /// エラー
    case error
    /// 取得されたコンテンツ
    case content(items: [ListingVideo], pageInfo: PageInfo)
}

public enum SearchServiceCommand {
    /// 検索結果をクリアする
    case clear
    /// 検索を実行する
    case search(query: SearchQuery)
}

/// @mockable
public protocol SearchServiceProtocol {
    var state: BehaviorRelay<SearchServiceQuery> { get }
    var command: PublishRelay<SearchServiceCommand> { get set }
}
