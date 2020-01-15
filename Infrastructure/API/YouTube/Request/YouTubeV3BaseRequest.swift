//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import APIKit

public protocol YouTubeV3BaseRequest: Request {
    var defaultDecoder: JSONDecoder { get }

    // MARK: - Request

    var baseURL: URL { get }
    var baseParameters: [String: Any] { get }
}

extension Request where Self: YouTubeV3BaseRequest {
    public var defaultDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }

    // MARK: - Request

    public var baseURL: URL {
        return URL(string: "https://www.googleapis.com/youtube/v3")!
    }

    public var baseParameters: [String: Any] {
        return [
            "key": "",
        ]
    }

    public var dataParser: DataParser {
        return NOPDataParser()
    }
}
