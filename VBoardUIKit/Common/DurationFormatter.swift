//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

enum DurationFormatter {
    static func string(from seconds: Int) -> String {
        let hour = String(format: "%02d", seconds / 3600)
        let sec = String(format: "%02d", (seconds % 3600) / 60)
        let min = String(format: "%02d", (seconds % 3600) % 60)
        return [hour, sec, min].joined(separator: ":")
    }

    static func integer(from format: String) -> Int? {
        let parts = format.split(separator: ":")
            .map { String($0) }
            .compactMap { integer(from: $0) }
        guard parts.count == 3 else { return nil }
        return parts[0] * 3600 + parts[1] * 60 + parts[2]
    }
}
