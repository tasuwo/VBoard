//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Nimble
import Quick

@testable import VBoard

class SearchViewControllerSpec: QuickSpec {
    override func spec() {
        var factory: ViewControllerFactoryMock!
        var viewController: SearchViewController!

        beforeEach {
            factory = ViewControllerFactoryMock()
            viewController = SearchViewController(factory: factory, viewModel: SearchViewModel())
            _ = viewController.view
        }

        describe("viewWillAppear") {
            beforeEach {
                viewController.viewWillAppear(false)
            }

            it("タイトルが設定される") {
                expect(viewController.title).to(equal(NSLocalizedString("SearchView.title", comment: "")))
            }
        }
    }
}
