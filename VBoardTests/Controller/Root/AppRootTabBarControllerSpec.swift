//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Nimble
import Quick

@testable import VBoard

class AppRootTabBarControllerSpec: QuickSpec {
    override func spec() {
        var factory: FactoryMock!
        var viewController: AppRootTabBarController!

        beforeEach {
            factory = FactoryMock()
            viewController = AppRootTabBarController(factory: factory)
            _ = viewController.view
        }

        describe("init") {
            it("タブに検索画面への遷移が表示される") {
                expect(viewController.viewControllers?.count).to(equal(1))

                expect(viewController.tabBar.items?.count).to(equal(1))

                let firstItem = viewController.viewControllers?[0] as? UINavigationController
                expect(viewController.viewControllers?[0]).to(beAnInstanceOf(UINavigationController.self))
                expect(firstItem?.viewControllers.count).to(equal(1))
                expect(firstItem?.viewControllers[0]).to(equal(factory.searchViewController))
            }
        }
    }
}
