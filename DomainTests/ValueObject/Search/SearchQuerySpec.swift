//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

@testable import Domain
import Nimble
import Quick

class SearchQuerySpec: QuickSpec {
    override func spec() {
        describe("SearchQuery.UploadDate") {
            context("publishedAfter(basedOn:)") {
                var uploadDate: SearchQuery.UploadDate!
                var date: Date!

                context("指定なし") {
                    beforeEach {
                        uploadDate = .any
                        date = Date(timeIntervalSince1970: 0)
                    }

                    it("nilを返す") {
                        expect(uploadDate.publishedAfter(basedOn: date)).to(beNil())
                    }
                }

                context("1時間以内") {
                    let testCases: [(source: Date, expected: Date)] = [
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 10, minute: 30, second: 30))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 9, minute: 30, second: 30))!
                        ),
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 2, hour: 0, minute: 0, second: 0))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 23, minute: 0, second: 0))!
                        ),
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2019, month: 12, day: 31, hour: 23, minute: 0, second: 0))!
                        ),
                    ]

                    beforeEach {
                        uploadDate = .hour
                    }

                    testCases.forEach { testCase in
                        context("基準日が\(testCase.source)") {
                            beforeEach {
                                date = testCase.source
                            }

                            it("1時間前の日時が返る") {
                                expect(uploadDate.publishedAfter(basedOn: date)).to(equal(testCase.expected))
                            }
                        }
                    }
                }

                context("本日") {
                    let testCases: [(source: Date, expected: Date)] = [
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 12, minute: 30, second: 30))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!
                        ),
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 1))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!
                        ),
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!
                        ),
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2019, month: 12, day: 31, hour: 23, minute: 59, second: 59))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2019, month: 12, day: 31, hour: 0, minute: 0, second: 0))!
                        ),
                    ]

                    beforeEach {
                        uploadDate = .today
                    }

                    testCases.forEach { testCase in
                        context("基準日が\(testCase.source)") {
                            beforeEach {
                                date = testCase.source
                            }

                            it("当日の0時0分が返る") {
                                expect(uploadDate.publishedAfter(basedOn: date)).to(equal(testCase.expected))
                            }
                        }
                    }
                }

                context("今週") {
                    let testCases: [(source: Date, expected: Date)] = [
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2019, month: 12, day: 29, hour: 0, minute: 0, second: 0))!
                        ),
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 8, hour: 0, minute: 0, second: 0))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 5, hour: 0, minute: 0, second: 0))!
                        ),
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 5, hour: 0, minute: 0, second: 0))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 5, hour: 0, minute: 0, second: 0))!
                        ),
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 11, hour: 0, minute: 0, second: 0))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 5, hour: 0, minute: 0, second: 0))!
                        ),
                    ]

                    beforeEach {
                        uploadDate = .thisWeek
                    }

                    testCases.forEach { testCase in
                        context("基準日が\(testCase.source)") {
                            beforeEach {
                                date = testCase.source
                            }

                            it("基準日の週の1日目の0時0分が返る") {
                                expect(uploadDate.publishedAfter(basedOn: date)).to(equal(testCase.expected))
                            }
                        }
                    }
                }

                context("今月") {
                    let testCases: [(source: Date, expected: Date)] = [
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 15, hour: 0, minute: 0, second: 0))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!
                        ),
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!
                        ),
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 31, hour: 0, minute: 0, second: 0))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!
                        ),
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 2, day: 15, hour: 0, minute: 0, second: 0))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 2, day: 1, hour: 0, minute: 0, second: 0))!
                        ),
                    ]

                    beforeEach {
                        uploadDate = .thisMonth
                    }

                    testCases.forEach { testCase in
                        context("基準日が\(testCase.source)") {
                            beforeEach {
                                date = testCase.source
                            }

                            it("基準日の月の1日の0時0分が返る") {
                                expect(uploadDate.publishedAfter(basedOn: date)).to(equal(testCase.expected))
                            }
                        }
                    }
                }

                context("今年") {
                    let testCases: [(source: Date, expected: Date)] = [
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 7, day: 7, hour: 0, minute: 0, second: 0))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!
                        ),
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!
                        ),
                        (
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 12, day: 31, hour: 23, minute: 59, second: 59))!,
                            Calendar(identifier: .gregorian).date(from: DateComponents(year: 2020, month: 1, day: 1, hour: 0, minute: 0, second: 0))!
                        ),
                    ]

                    beforeEach {
                        uploadDate = .thisYear
                    }

                    testCases.forEach { testCase in
                        context("基準日が\(testCase.source)") {
                            beforeEach {
                                date = testCase.source
                            }

                            it("基準日の年の1月1日の0時0分が返る") {
                                expect(uploadDate.publishedAfter(basedOn: date)).to(equal(testCase.expected))
                            }
                        }
                    }
                }
            }
        }
    }
}
