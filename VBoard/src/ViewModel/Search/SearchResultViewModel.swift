//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Domain
import RxRelay
import RxSwift

class SearchResultViewModel {
    private let service: SearchServiceProtocol

    private(set) var query: BehaviorRelay<String?>
    let searchedQuery: String
    private(set) var items: BehaviorRelay<[ListingVideo]> = BehaviorRelay(value: [])

    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    init(service: SearchServiceProtocol, query: String) {
        self.service = service
        self.query = BehaviorRelay(value: query)
        self.searchedQuery = query

        self.service.state
            .compactMap { state in
                switch state {
                case let .content(items: items, pageInfo: _):
                    return items

                default:
                    return nil
                }
            }
            .bind(to: self.items)
            .disposed(by: self.disposeBag)
    }

    // MARK: - Methods

    func doSearch() {
        if let query = self.query.value {
            self.service.command.accept(.search(query: .init(query: query)))
        }
    }
}
