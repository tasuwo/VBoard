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
    var selected: PublishRelay<Int> { get }
}

protocol SearchResultViewModelOutputs {
    var searchedQuery: String { get }
    var items: Driver<[ListingVideo]> { get }
    var played: Signal<ListingVideo> { get }
}

class SearchResultViewModel: SearchResultViewModelType, SearchResultViewModelInputs, SearchResultViewModelOutputs {
    // MARK: - SearchResultViewModelType

    var inputs: SearchResultViewModelInputs { self }
    var outputs: SearchResultViewModelOutputs { self }

    // MARK: - SearchResultViewModelInputs

    var selected: PublishRelay<Int>
    var loaded: PublishRelay<Void>

    // MARK: - SearchResultViewModelOutputs

    let searchedQuery: String
    var items: Driver<[ListingVideo]>
    var played: Signal<ListingVideo>

    // MARK: - Privates

    private(set) var _items: BehaviorRelay<[ListingVideo]> = BehaviorRelay(value: [])
    private(set) var _played: PublishRelay<ListingVideo> = .init()

    private let service: SearchServiceProtocol

    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    init(service: SearchServiceProtocol, query: String) {
        self.service = service

        // MARK: Inputs

        self.selected = .init()
        self.loaded = .init()

        // MARK: Outputs

        self.searchedQuery = query
        self.items = self._items.asDriver()
        self.played = self._played.asSignal()

        // MARK: Binding

        self.selected
            .compactMap { [weak self] index -> ListingVideo? in
                guard self?._items.value.indices.contains(index) == true else { return nil }
                return self?._items.value[index]
            }
            .bind(to: self._played)
            .disposed(by: self.disposeBag)

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
