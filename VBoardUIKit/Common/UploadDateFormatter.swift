//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

enum UploadDateFormatter {
    static func string(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.locale = .init(identifier: "ja_JP")
        return formatter.string(from: date)
    }

    static func date(from string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.locale = .init(identifier: "ja_JP")
        return formatter.date(from: string)
    }
}
