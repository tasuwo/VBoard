//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Nimble
import Quick

@testable import VBoardUIKit

class DurationFormatterSpec: QuickSpec {
    override func spec() {
        describe("string(from:)") {
            var value: String!
            let testCases: [(source: Int, expected: String)] = [
                (25, "00:00:25"),
                (60, "00:01:00"),
                (85, "00:01:25"),
                (60 * 60, "01:00:00"),
                ((60 * 60) + 25, "01:00:25"),
                ((60 * 60) + 85, "01:01:25"),
                (60 * 60 * 60, "60:00:00"),
                (60 * 60 * 60 * 2, "120:00:00"),
            ]

            testCases.forEach { source, expected in
                context("\(source)秒を変換する") {
                    beforeEach {
                        value = DurationFormatter.string(from: source)
                    }
                    it("\(expected) になる") {
                        expect(value).to(equal(expected))
                    }
                }
            }
        }

        describe("interger(from:)") {
            var value: Int!
            let testCases: [(source: String, expected: Int)] = [
                ("00:00:25", 25),
                ("00:01:00", 60),
                ("00:01:25", 85),
                ("01:00:00", 60 * 60),
                ("01:00:25", (60 * 60) + 25),
                ("01:01:25", (60 * 60) + 85),
                ("60:00:00", 60 * 60 * 60),
                ("120:00:00", 60 * 60 * 60 * 2),
            ]

            testCases.forEach { source, expected in
                context("\(source) を変換する") {
                    beforeEach {
                        value = DurationFormatter.integer(from: source)
                    }
                    it("\(expected)秒になる") {
                        expect(value).to(equal(expected))
                    }
                }
            }
        }
    }
}
