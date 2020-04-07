//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Domain
import RxCocoa
import RxRelay
import RxSwift

protocol SearchEntryViewModelType {
    var inputs: SearchEntryViewModelInputs { get }
    var outputs: SearchEntryViewModelOutputs { get }
}

protocol SearchEntryViewModelInputs {
    var entry: BehaviorRelay<String?> { get }
    var searchButtonClicked: PublishRelay<Void> { get }
}

protocol SearchEntryViewModelOutputs {
    var searchResultViewShown: Signal<String> { get }
}

class SearchEntryViewModel: SearchEntryViewModelType, SearchEntryViewModelInputs, SearchEntryViewModelOutputs {
    // MARK: - SearchEntryViewModelType

    var inputs: SearchEntryViewModelInputs { self }
    var outputs: SearchEntryViewModelOutputs { self }

    // MARK: - SearchEntryViewModelInputs

    var entry: BehaviorRelay<String?>
    var searchButtonClicked: PublishRelay<Void>

    // MARK: - SearchEntryViewModelOutputs

    var searchResultViewShown: Signal<String>

    // MARK: - Privates

    private let _searchResultViewShown: PublishRelay<String> = .init()

    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    init() {
        // MARK: Inputs

        self.entry = .init(value: nil)
        self.searchButtonClicked = .init()

        // MARK: Outputs

        self.searchResultViewShown = self._searchResultViewShown
            .asSignal(onErrorSignalWith: .empty())

        // MARK: Binding

        self.searchButtonClicked
            .compactMap { [weak self] _ -> String? in
                return self?.entry.value
            }
            .filter { !$0.isEmpty }
            .bind(to: self._searchResultViewShown)
            .disposed(by: self.disposeBag)
    }
}
