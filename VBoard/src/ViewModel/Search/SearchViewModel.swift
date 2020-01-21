//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Domain
import RxRelay
import RxSwift

class SearchViewModel {
    private(set) var query = BehaviorRelay<String?>(value: nil)
}
