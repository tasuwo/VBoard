//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import APIKit
import RxSwift

extension APIKit.Request {
    func rx_request() -> Observable<Self.Response> {
        return Observable.create { observer in
            let task = Session.shared.send(self) { result in
                switch result {
                case let .success(response):
                    observer.on(.next(response))
                    observer.on(.completed)
                case let .failure(error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
