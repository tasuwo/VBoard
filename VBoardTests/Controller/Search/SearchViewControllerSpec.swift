//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Nimble
import Quick

@testable import VBoard

class SearchViewControllerSpec: QuickSpec {
    override func spec() {
        var factory: ViewControllerFactoryMock!
        var viewController: SearchEntryViewController!

        beforeEach {
            factory = ViewControllerFactoryMock()
            viewController = SearchEntryViewController(factory: factory, viewModel: SearchEntryViewModel())
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
