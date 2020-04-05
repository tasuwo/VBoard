//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import APIKit
import Domain
import RxRelay
import RxSwift

public class SearchService: SearchServiceProtocol {
    // MARK: - SearchServiceProtocol

    public var state: BehaviorRelay<SearchServiceQuery> = BehaviorRelay(value: .notLoaded)
    public var command: PublishRelay<SearchServiceCommand> = PublishRelay()

    // MARK: - Properties

    private let disposeBag = DisposeBag()
    private let queue = DispatchQueue(label: "net.tasuwo.Infrastructure.SearchService")

    // MARK: - Lifecycle

    public init() {
        let searchState = command
            .observeOn(ConcurrentDispatchQueueScheduler(queue: queue))
            .filter { $0.isSearch }
            .map { _ in SearchServiceQuery.progress }

        let searchResult = command
            .observeOn(ConcurrentDispatchQueueScheduler(queue: queue))
            .filter { $0.isSearch }
            .flatMapLatest { command -> Observable<YouTube.SearchApiResponse> in
                switch command {
                case let .search(query: query):
                    return YouTube.SearchRequest(query: query).rx_request()

                default:
                    return .never()
                }
            }
            .map { response -> SearchServiceQuery in
                let items = response.items.map { $0.convertToDomainModel() }
                let pageInfo = PageInfo(totalResults: response.pageInfo.totalResults,
                                        resultsPerPage: response.pageInfo.resultsPerPage,
                                        prevPageToken: response.prevPageToken,
                                        nextPageToken: response.nextPageToken)
                return .content(items: items, pageInfo: pageInfo)
            }

        Observable
            .merge(searchState, searchResult)
            .bind(to: self.state)
            .disposed(by: self.disposeBag)
    }
}

private extension SearchServiceCommand {
    var isSearch: Bool {
        if case .search(query: _) = self {
            return true
        } else {
            return false
        }
    }
}
