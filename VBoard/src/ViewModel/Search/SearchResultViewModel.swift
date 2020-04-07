//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Domain
import RxCocoa
import RxRelay
import RxSwift

protocol SearchResultViewModelType {
    var inputs: SearchResultViewModelInputs { get }
    var outputs: SearchResultViewModelOutputs { get }
}

protocol SearchResultViewModelInputs {
    var loaded: PublishRelay<Void> { get }
}

protocol SearchResultViewModelOutputs {
    var searchedQuery: String { get }
    var items: Driver<[ListingVideo]> { get }
}

class SearchResultViewModel: SearchResultViewModelType, SearchResultViewModelInputs, SearchResultViewModelOutputs {
    // MARK: - SearchResultViewModelType

    var inputs: SearchResultViewModelInputs { self }
    var outputs: SearchResultViewModelOutputs { self }

    // MARK: - SearchResultViewModelInputs

    var loaded: PublishRelay<Void>

    // MARK: - SearchResultViewModelOutputs

    let searchedQuery: String
    var items: Driver<[ListingVideo]>

    // MARK: - Privates

    private(set) var _items: BehaviorRelay<[ListingVideo]> = BehaviorRelay(value: [])

    private let service: SearchServiceProtocol

    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    init(service: SearchServiceProtocol, query: String) {
        self.service = service

        // MARK: Inputs

        self.loaded = .init()

        // MARK: Outputs

        self.searchedQuery = query
        self.items = self._items.asDriver()

        // MARK: Binding

        self.loaded
            .compactMap { [weak self] _ -> SearchServiceCommand? in
                guard let self = self else { return nil }
                return .search(query: .init(query: self.searchedQuery))
            }
            .bind(to: self.service.command)
            .disposed(by: self.disposeBag)

        self.service.state
            .compactMap { state in
                switch state {
                case let .content(items: items, pageInfo: _):
                    return items

                default:
                    return nil
                }
            }
            .bind(to: self._items)
            .disposed(by: self.disposeBag)
    }
}
