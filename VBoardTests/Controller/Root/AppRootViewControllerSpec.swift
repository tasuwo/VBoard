//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Nimble
import Quick

@testable import VBoard

class AppRootViewControllerSpec: QuickSpec {
    override func spec() {
        var factory: FactoryMock!
        var viewController: AppRootViewController!

        beforeEach {
            factory = FactoryMock()
            viewController = AppRootViewController(factory: factory)
            _ = viewController.view
        }

        describe("init") {
            it("RootTabBarのViewが追加される") {
                expect(viewController.view.subviews).to(contain(factory.rootTabBarController.view))
            }
        }
    }
}
