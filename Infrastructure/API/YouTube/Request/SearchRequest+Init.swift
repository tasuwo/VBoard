//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Domain

extension YouTube.SearchRequest {
    init(query: SearchQuery) {
        self.parts = .init(arrayLiteral: .id, .snippet)
        self.filter = nil
        self.channelId = nil
        self.channelType = nil
        self.eventType = nil
        self.maxResults = query.pageSize
        self.onBehalfOfContentOwner = nil
        self.order = .init(order: query.sortOrder)
        self.pageToken = query.pageToken
        self.publishedAfter = query.uploadDate.publishedAfter(basedOn: Date())
        self.publishedBefore = nil
        self.query = query.query
        self.regionCode = nil
        self.safeSearch = nil
        self.topicId = nil
        // とりあえず、動画のみ
        self.type = .video
        self.videoCaption = nil
        self.videoCategoryId = nil
        self.videoDefinition = nil
        self.videoDimention = nil
        self.videoDuration = .init(length: query.length)
        self.videoEmbeddable = nil
        self.videoLicense = nil
        self.videoSyndicated = nil
        self.videoType = nil
    }
}

extension YouTube.SearchRequest.Order {
    init(order: SearchQuery.SortOrder) {
        switch order {
        case .date:
            self = .date

        case .rating:
            self = .rating

        case .relevance:
            self = .relevance

        case .title:
            self = .title

        case .videoCount:
            self = .videoCount

        case .viewCount:
            self = .viewCount
        }
    }
}

extension YouTube.SearchRequest.VideoDuration {
    init(length: SearchQuery.Length) {
        switch length {
        case .any:
            self = .any

        case .long:
            self = .long

        case .medium:
            self = .medium

        case .short:
            self = .short
        }
    }
}
